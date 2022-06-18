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
    
    var homeImageViewController: HomeImageViewController? 
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    func goToImageView() {
        let vc = HomeImageViewController()
        let vm = HomeImageViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        vc.modalPresentationStyle = .overCurrentContext
        homeViewController.definesPresentationContext = true
        vc.transitioningDelegate = homeViewController
        homeViewController.present(vc, animated: true)
    }
    
    func goToTitleView() {
        homeImageViewController = HomeImageViewController()
        let vm = HomeImageViewModel()
        vm.coordinator = self
        homeImageViewController?.viewModel = vm
        homeViewController.dismiss(animated: true)
        homeImageViewController = nil
    }
}
