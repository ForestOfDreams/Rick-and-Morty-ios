//
//  Character.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

struct Character: Codable, Equatable {
    let id: Int
    let image: String
    let name: String
    let species: String
    let gender: Gender
    let status: Status
    var isFavorite: Bool
    
    enum Status: String, Codable, Equatable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Codable, Equatable {
        case alive = "Female"
        case dead = "Male"
        case genderless = "Genderless"
        case unknown
    }
}
