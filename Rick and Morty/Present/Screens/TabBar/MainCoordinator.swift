//
//  MainCoordinator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 23.05.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    lazy var rootViewController: TabBarController = {
        let vc = TabBarController()
        let vm = TabBarViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        return vc
    }()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        let homeCoordinator = HomeTabCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let homeViewController = homeCoordinator.rootViewController
        homeViewController.extendedLayoutIncludesOpaqueBars = true
        
        let searchCoordinator = SearchTabCoordinator()
        searchCoordinator.start()
        self.childCoordinators.append(searchCoordinator)
        let searchViewController = searchCoordinator.rootViewController
        
        let favoritesCoordinator = FavoritesTabCoordinator()
        favoritesCoordinator.start()
        self.childCoordinators.append(favoritesCoordinator)
        let favoritesViewController = favoritesCoordinator.rootViewController
        
        self.rootViewController.addChildViewControllers(
            homeController: homeViewController,
            favoriteController: favoritesViewController,
            searchController: searchViewController
        )
    }
}
