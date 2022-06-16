//
//  ApiError.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

struct ServerError: Error, Decodable {
    
    init?(from response: URLResponse) {
        if let response = response as? HTTPURLResponse, response.statusCode < 200 && response.statusCode >= 300 {
            self.code = response.statusCode
            self.description = response.description
        }
       return nil
    }
    
    let code: Int
    let description: String
}
