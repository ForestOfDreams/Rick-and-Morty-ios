//
//  TabBarController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var viewModel : TabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewControllers = []
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        tabBar.backgroundColor = .BG
        tabBar.unselectedItemTintColor = .main
        tabBar.tintColor = .main
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .BG
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    func addChildViewControllers(
        homeController: UIViewController,
        favoriteController: UIViewController,
        searchController: UIViewController
    ) {
        setupHomeTabBarItem(homeController)
        setupFavoriteTabBarItem(favoriteController)
        setupSearchTabBarItem(searchController)
        
        self.viewControllers = [
            homeController,
            favoriteController,
            searchController
        ]
        
        self.selectedIndex = viewModel.getTab().rawValue
    }
    
    private func setupHomeTabBarItem(_ controller: UIViewController) {
        setupTabBarItem(
            vc: controller,
            imageName: "house",
            selectedImageName: "house.circle.fill"
        )
    }
    
    private func setupFavoriteTabBarItem(_ controller: UIViewController) {
        setupTabBarItem(
            vc: controller,
            imageName: "heart",
            selectedImageName: "heart.circle.fill"
        )
    }
    
    private func setupSearchTabBarItem(_ controller: UIViewController) {
        setupTabBarItem(
            vc: controller,
            imageName: "magnifyingglass",
            selectedImageName: "magnifyingglass.circle.fill"
        )
    }
    
    private func setupTabBarItem(vc: UIViewController, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)?.resized(to: CGSize(width: 36, height: 36))
        let tabBarItem = UITabBarItem(title: nil, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        viewModel.saveTab(tabBarIndex)
        UserLogger.shared.log(test: "Tab bar \(tabBarIndex) was open", level: .info)
    }
}
