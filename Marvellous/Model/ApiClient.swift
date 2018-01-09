//
//  ApiClient.swift
//  Marvellous
//
//  Created by Martin Curtis on 09/01/2018.
//  Copyright © 2018 Martin Curtis. All rights reserved.
//

import Foundation

class ApiClient {
    var responseData: ApiResponse?
    
    func makeRequest(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: url)!, completionHandler: completionHandler)
        
        task.resume()
    }

    func decodeResponse(json: String) -> ApiResponse {
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let data = try! decoder.decode(ApiResponse.self, from: jsonData)
        
        return data
    }
}
