//
//  PagedResults.swift
//  Marvellous
//
//  Created by Martin Curtis on 09/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import Foundation

struct PagedResults: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}
