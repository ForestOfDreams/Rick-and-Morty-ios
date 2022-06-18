//
//  SearchTabCoordinator.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 23.05.2022.
//

import Foundation
import UIKit

class SearchTabCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var searchViewController: SearchViewController = {
        let vc = SearchViewController()
        let vm = SearchViewModel()
        vm.coordinator = self
        vc.viewModel = vm
        return vc
        
    }()
    
    func start() {
        rootViewController.setViewControllers([searchViewController], animated: false)
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
