//
//  Endpoint+Character.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

extension Endpoint {
    
    static var getAllCharacters: Self {
        return Endpoint(path: "/api/character")
    }
}
