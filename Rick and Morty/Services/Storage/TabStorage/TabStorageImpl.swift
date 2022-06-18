//
//  TabStorageImpl.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

struct TabStorageImpl: TabStorage {
    private let storage: StorageImpl
    static let tabKey = "tab"
    
    init(storage: Storage = StorageImpl()) {
        self.storage = StorageImpl()
    }
    
    func saveTab(_ tab: Tab) {
        storage.save(key: TabStorageImpl.tabKey, value: tab.rawValue)
    }
    
    func getTab() -> Tab {
        let rawValue: Int? = storage.get(key: TabStorageImpl.tabKey)
        
        return Tab(rawValue: rawValue ?? 0) ?? .home
    }
}
