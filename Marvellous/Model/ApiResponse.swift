//
//  ApiResponse.swift
//  Marvellous
//
//  Created by Martin Curtis on 07/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import Foundation

struct ApiResponse: Codable {
    let code: Int
    let status: String
    let etag: String
    let data: PagedResults
}
