//
//  StorageImpl.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

struct StorageImpl: Storage {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func get<T>(key: String) -> T? {
        return self.userDefaults.object(forKey: key) as? T
    }
    
    func save<T>(key: String, value: T?) {
        self.userDefaults.set(value, forKey: key)
    }
}
