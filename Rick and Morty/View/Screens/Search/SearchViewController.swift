//
//  SearchViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit
import Combine

final class SearchViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    var showCharacterDetailRequested: (String) -> () = { name in }
    
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
//        view.isUserInteractionEnabled = false
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        
        view.addSubview(searchResults.view)
        view.addSubview(suggests.view)
        view.addSubview(searchBar)
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            searchResults.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            searchResults.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResults.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResults.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            suggests.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            suggests.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            suggests.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            suggests.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        searchBar.textField.textPublisher()
            .sink { [weak self] in
                if $0.isEmpty {
                    self?.searchResults.view.alpha = 0
                    self?.suggests.view.alpha = 1
                } else {
                    self?.searchResults.view.alpha = 1
                    self?.suggests.view.alpha = 0
                }
            }
            .store(in: &subscriptions)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateInfo() {
        
    }
    
    private let model: Model
    
    private lazy var searchBar: SearchBar = {
        return SearchBar()
    }()
    
    private lazy var suggests: SearchSuggestsViewController = {
        return SearchSuggestsViewController(model: model.suggests, showCharacterDetailRequested: showCharacterDetailRequested)
    }()
    
    private lazy var searchResults: SearchResultsViewController = {
        return SearchResultsViewController(model: model.searchResults, showCharacterDetailRequested: showCharacterDetailRequested)
    }()
}
