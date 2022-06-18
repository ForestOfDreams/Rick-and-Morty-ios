//
//  CharacterStorage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

enum Category: String, Codable {
    case searched
    case favorites
}

protocol CharacterStorage {
    func saveCharacters(_ characters: [Character], for category: Category)
    func getCharacters(from category: Category) -> [Character]
    func addOrRemoveCharacter(_ character: Character, for category: Category)
    func addCharacter(_ character: Character, for category: Category)
}
