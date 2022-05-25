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
        let vc = FavoritesViewController(model: MockData().favoriteModel)
        vc.title = "Favorites"
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([favoritesViewController], animated: false)
        rootViewController.navigationBar.prefersLargeTitles = true
        favoritesViewController.showCharacterDetailRequested = { [weak self] name in
            self?.goToCharacterDetail()
        }
    }
    
    func goToCharacterDetail() {
        rootViewController.pushViewController(CharacterViewController(model: MockData().characterModel), animated: true)
//        rootViewController.pushViewController(UIHostingController(rootView: CharacterScreen()), animated: true)
    }
}
