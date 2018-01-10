//
//  ViewController.swift
//  Marvellous
//
//  Created by Martin Curtis on 07/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController, UITableViewDelegate, URLSessionDelegate {
    
    var viewModel: ViewModel?
    var detailViewController: DetailViewController? = nil
    var characters: [Character] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        viewModel = ViewModel(viewController: self)
        
        guard let vModel = viewModel else {
            return
        }
        
        table.delegate = self
        table.dataSource = vModel
        
        vModel.getCharacters()
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
}

