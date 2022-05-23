//
//  tabBarController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNavigationController = UINavigationController(
            rootViewController: HomeViewController(
                model: HomeViewController.Model()
            )
        )
        
        let favoriteNavigationController = UINavigationController(
            rootViewController: FavoritesViewController(
                model: MockData().favoriteModel
            )
        )
        favoriteNavigationController.navigationBar.prefersLargeTitles = true
        
        let characterNavigationController = UINavigationController(
            rootViewController: CharacterViewController(
                model: MockData().characterModel
            )
        )
        characterNavigationController.tabBarItem = .init(title: "", image: UIImage(systemName: "character"), tag: 0)
        let searchNavigationController = UINavigationController(
            rootViewController: SearchViewController(
                model: MockData().searchModel
            )
        )
        self.setViewControllers(
            [homeNavigationController, favoriteNavigationController, searchNavigationController, characterNavigationController],
            animated: false
        )
        
        let images = ["house", "heart", "magnifyingglass", "character"]
        
        if let items = tabBar.items {
            for item in 0..<images.count {
                items[item].title = ""
                items[item].title = ""
                items[item].image = UIImage(systemName: images[item])
                //                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
            }
        }
    }
}
