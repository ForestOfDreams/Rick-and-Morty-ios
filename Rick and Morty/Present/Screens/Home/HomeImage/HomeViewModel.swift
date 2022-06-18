//
//  HomeViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 16.06.2022.
//

import Foundation

class HomeViewModel {
    weak var coordinator : HomeTabCoordinator!
    
    func goToImageView() {
        coordinator.goToImageView()
    }
}
