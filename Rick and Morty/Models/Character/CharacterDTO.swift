//
//  Character.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let image: String
    let name: String
    let species: String
    let gender: Gender
    let status: Status
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Decodable {
        case alive = "Female"
        case dead = "Male"
        case genderless = "Genderless"
        case unknown
    }
}
