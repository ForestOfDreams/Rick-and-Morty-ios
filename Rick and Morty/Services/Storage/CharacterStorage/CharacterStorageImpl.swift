//
//  CharacterStorageImpl.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

struct CharacterStorageImpl: CharacterStorage {
    private let storage: StorageImpl
    
    init(storage: Storage = StorageImpl()) {
        self.storage = StorageImpl()
    }
    
    func saveCharacters(_ characters: [Character], for category: Category) {
        storage.save(key: category.rawValue, value: try? PropertyListEncoder().encode(characters))
    }
    
    func getCharacters(from category: Category) -> [Character] {
        if let data: Data = storage.get(key: category.rawValue) {
            let characters = try? PropertyListDecoder().decode(Array<Character>.self, from: data)
            return characters ?? []
        }
        return []
    }
    
    func addOrRemoveCharacter(_ character: Character, for category: Category) {
        var characters = getCharacters(from: category)
        if !characters.contains(where: {
            $0.name == character.name
        }) {
            characters.append(character)
        } else {
            characters.removeAll {
                $0.name == character.name
            }
        }
        storage.save(key: category.rawValue, value: try? PropertyListEncoder().encode(characters))
    }
    
    func addCharacter(_ character: Character, for category: Category) {
        var characters = getCharacters(from: category)
        if !characters.contains(where: {
            $0.name == character.name
        }) {
            characters.append(character)
        }
        storage.save(key: category.rawValue, value: try? PropertyListEncoder().encode(characters))
    }
}
