//
//  Endpoint+URL.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

extension Endpoint {
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
}
