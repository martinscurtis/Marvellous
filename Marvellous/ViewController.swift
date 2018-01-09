//
//  ViewController.swift
//  Marvellous
//
//  Created by Martin Curtis on 07/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDelegate {
    
    var detailViewController: DetailViewController? = nil
    
    let client = ApiClient()
    let url = "https://gateway.marvel.com:443/v1/public/characters?orderBy=name&limit=100&offset=0&apikey="
    
    var characters: [Character] = []
    
    @IBOutlet weak var table: UITableView!
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = characters[indexPath.row].name
        
        return cell
    }
    
    func getCharacters() {
        
        let ts = Date().timeIntervalSince1970
        
        let stringToHash = String(ts) + Config.privateKey.rawValue + Config.publicKey.rawValue
        
        let fullUrl = url +
            Config.publicKey.rawValue +
            "&ts=" +
            String(ts) +
            "&hash=" + stringToHash.md5()
        
        client.makeRequest(url: fullUrl, completionHandler: processData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        table.delegate = self
        table.dataSource = self
        
        self.getCharacters()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = table.indexPathForSelectedRow {
                let object = characters[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pass any object as parameter, i.e. the tapped row
        performSegue(withIdentifier: "showDetails", sender: indexPath.row)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func processData(data: Data?, response: URLResponse?, error: Error?) -> Void {
        let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
        let apiResponse = client.decodeResponse(json: outputStr!)
        characters = apiResponse.data.results
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}

