//
//  TabBarViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

class TabBarViewModel {
    weak var coordinator : MainCoordinator!
    
    private var storage: TabStorage
    
    init() {
        storage = TabStorageImpl()
    }
    
    func saveTab(_ tabIndex: Int) {
        storage.saveTab(Tab(rawValue: tabIndex) ?? Tab.home)
    }
    
    func getTab() -> Tab {
        storage.getTab()
    }
}
