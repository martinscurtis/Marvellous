//
//  Character.swift
//  Marvellous
//
//  Created by Martin Curtis on 09/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let resourceURI: URL
}
