//
//  Endpoint+Character.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

extension Endpoint {
    
    static var getCharacters: Self {
        return Endpoint(path: "/api/character")
    }
    
    static func searchCharacters(name: String) -> Self {
        return Endpoint(
            path: "/api/character",
            queryItems: [
                URLQueryItem(name: "name", value: name)
            ]
        )
    }
}
