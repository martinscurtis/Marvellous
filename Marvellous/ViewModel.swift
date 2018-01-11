//
//  ViewModel.swift
//  Marvellous
//
//  Created by Martin Curtis on 10/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import UIKit
import Foundation

class ViewModel: NSObject, UITableViewDataSource {
    
    let client = ApiClient()
    let url = "https://gateway.marvel.com:443/v1/public/characters?orderBy=name&limit=100&offset=0&apikey="
    
    var viewController: ViewController?
    
    init(viewController: ViewController) {
        self.viewController = viewController
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
    
    func processData(data: Data?, response: URLResponse?, error: Error?) -> Void {
        let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
        let apiResponse = client.decodeResponse(json: outputStr!)
        guard let controller = viewController else {
            return
        }
        controller.setCharacters(characters: apiResponse.data.results)
        
        DispatchQueue.main.async {
            controller.table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let controller = viewController else {
            return 1
        }
        return controller.getCharacters().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ThumbnailCell", owner: self, options: nil)?.first as! ThumbnailCell
        
        guard let controller = viewController else {
            return cell
        }
        let characters = controller.getCharacters()
        
        let url = characters[indexPath.row].thumbnail.path.absoluteString + "/standard_small." + characters[indexPath.row].thumbnail.extension
        if let data = try? Data(contentsOf: URL(string: url)!) {
            cell.thumbImage.image = UIImage(data: data)!
        }
         cell.thumbLabel.text = characters[indexPath.row].name
        
        return cell
    }
}
