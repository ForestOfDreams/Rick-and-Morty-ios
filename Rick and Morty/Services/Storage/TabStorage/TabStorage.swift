//
//  TabStorage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

enum Tab: Int, Codable {
    case home = 0
    case favorites = 1
    case search = 2
}

protocol TabStorage {
    func saveTab(_ tab: Tab)
    func getTab() -> Tab
}
