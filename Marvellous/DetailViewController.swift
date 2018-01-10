//
//  DetailViewController.swift
//  Marvellous
//
//  Created by Martin Curtis on 07/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    var detailItem: Character? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        guard let detail = detailItem else {
            return
        }
        
        if let label = detailNameLabel {
            label.text = detail.name
        }
        if let label = detailDescriptionLabel {
            label.text = detail.description
        }
        
        guard let imageView = detailImage else {
            return
        }
        let url = detail.thumbnail.path.absoluteString + "/standard_fantastic." + detail.thumbnail.extension
        if let data = try? Data(contentsOf: URL(string: url)!) {
             imageView.image = UIImage(data: data)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
