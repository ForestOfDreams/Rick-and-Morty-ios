//
//  FavoriteTabCoordinator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 23.05.2022.
//

import Foundation
import UIKit
import SwiftUI

class FavoritesTabCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    
    lazy var favoritesViewController: FavoritesViewController = {
        let vc = FavoritesViewController()
        let vm = FavoritesViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        vc.title = "Favorites"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([favoritesViewController], animated: false)
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    func goToCharacterDetail(_ character: Character) {
        let vc = CharacterViewController()
        let vm = CharacterViewModel(character: character)
        vc.viewModel = vm
        rootViewController.pushViewController(
            vc,
            animated: true
        )
    }
}
