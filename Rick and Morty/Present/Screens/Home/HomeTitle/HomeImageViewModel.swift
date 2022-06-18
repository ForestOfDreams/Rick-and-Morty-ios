//
//  HomeImageViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.06.2022.
//

import Foundation

class HomeImageViewModel {
    weak var coordinator : HomeTabCoordinator!
    
    func goToTitleView() {
        coordinator.goToTitleView()
    }
}
