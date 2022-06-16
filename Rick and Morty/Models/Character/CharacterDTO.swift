//
//  Character.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let status: Status
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
}
