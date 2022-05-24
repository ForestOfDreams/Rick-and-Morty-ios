//
//  MainCoordinator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 23.05.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    lazy var rootViewController: UITabBarController = {
        let ret = UITabBarController()
        ret.tabBar.backgroundColor = .BG
        ret.tabBar.unselectedItemTintColor = .main
        ret.tabBar.tintColor = .main
        return ret
    }()
    
    var childCoordinators = [Coordinator]()
    
    func start() {
        let homeCoordinator = HomeTabCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let homeViewController = homeCoordinator.rootViewController
        setup(
            vc: homeViewController,
            imageName: "house",
            selectedImageName: "house.circle.fill"
        )
        homeViewController.extendedLayoutIncludesOpaqueBars = true
        
        let searchCoordinator = SearchTabCoordinator()
        searchCoordinator.start()
        self.childCoordinators.append(searchCoordinator)
        let searchViewController = searchCoordinator.rootViewController
        setup(
            vc: searchViewController,
            imageName: "magnifyingglass",
            selectedImageName: "magnifyingglass.circle.fill"
        )
        
        let favoritesCoordinator = FavoritesTabCoordinator()
        favoritesCoordinator.start()
        self.childCoordinators.append(favoritesCoordinator)
        let favoritesViewController = favoritesCoordinator.rootViewController
        setup(
            vc: favoritesViewController,
            imageName: "heart",
            selectedImageName: "heart.circle.fill"
        )
        
        self.rootViewController.viewControllers = [
            homeViewController,
            favoritesViewController,
            searchViewController
        ]
    }
    
    func setup(vc: UIViewController, imageName: String, selectedImageName: String) {
           let defaultImage = UIImage(systemName: imageName)
           let selectedImage = UIImage(systemName: selectedImageName)?.resized(to: CGSize(width: 36, height: 36))
           let tabBarItem = UITabBarItem(title: nil, image: defaultImage, selectedImage: selectedImage)
           vc.tabBarItem = tabBarItem
       }
}
