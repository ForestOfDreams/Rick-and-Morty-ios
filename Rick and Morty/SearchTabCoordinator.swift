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
        let vc = SearchViewController(model: MockData().searchModel)
        
        return vc
        
    }()
    
    func start() {
        rootViewController.setViewControllers([searchViewController], animated: false)
        searchViewController.showCharacterDetailRequested = { [weak self] name in
            self?.goToCharacterDetail()
        }
    }
    
    func goToCharacterDetail() {
        rootViewController.pushViewController(CharacterViewController(model: MockData().characterModel), animated: true)
    }
}
