//
//  Storage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 07.06.2022.
//

import Foundation
import SwiftUI

protocol Storage {
    func save<T: Codable>(_data: T, forKey key: String)
    func get<T: Codable>(forKey key: String) -> T?
}

protocol CharacterStorage {
    func saveCharacters(_ characters: [Character], for category: Category) async throws
    func getCharacters(from category: Category) async -> [Character]
}

enum Tab: String {
    case main
    case favorites
}

enum Category {
    case searched
    case favorites
}

