//
//  SearchViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    struct Model {
        let suggests: SearchSuggestsViewController.Model
        let searchResults: SearchResultsViewController.Model
    }
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        
        view.addSubview(searchResults.view)
        searchResults.view.translatesAutoresizingMaskIntoConstraints = false
        searchResults.view.pinSafeArea(to: view)
    }
    
    private func updateInfo() {
        
    }
    
    private let model: Model
    
    private lazy var suggests: SearchSuggestsViewController = {
        return SearchSuggestsViewController(model: model.suggests)
    }()
    
    private lazy var searchResults: SearchResultsViewController = {
        return SearchResultsViewController(model: model.searchResults)
    }()
}
