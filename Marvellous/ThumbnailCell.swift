//
//  ThumbnailCell.swift
//  Marvellous
//
//  Created by Martin Curtis on 10/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import UIKit

class ThumbnailCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var thumbLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
