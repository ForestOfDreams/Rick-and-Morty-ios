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
        let vm = HomeViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    func goToImageView() {
        let homeImageViewViewController = HomeImageViewController()
        homeImageViewViewController.modalPresentationStyle = .overCurrentContext
        homeViewController.definesPresentationContext = true
        homeImageViewViewController.transitioningDelegate = homeViewController
        homeViewController.present(homeImageViewViewController, animated: true)
    }
}
