//
//  HomeTabCoordinator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 23.05.2022.
//

import Foundation
import UIKit

class HomeTabCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController(model: HomeViewController.Model())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
}
