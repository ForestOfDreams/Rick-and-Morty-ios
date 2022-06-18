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
    
    var viewModel : SearchViewModel!
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupSearchUI() {
        NSLayoutConstraint.activate([
            searchResults.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            searchResults.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResults.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResults.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSuggestUI() {
        NSLayoutConstraint.activate([
            suggests.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            suggests.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            suggests.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            suggests.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.backgroundColor = .BG
        
        view.addSubview(searchBar)
        
        searchBar.textField.delegate = self
        
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        searchBar.textField.createBinding(with: viewModel.searchText, storeIn: &subscriptions)
        
        searchBar.textField.textPublisher()
            .sink { [weak self] in
                guard let self = self else { return }
                if $0.isEmpty {
                    self.showSuggestView()
                } else {
                    self.showSearchView()
                }
            }
            .store(in: &subscriptions)
        
        showSuggestView()
    }
    
    func showSuggestView() {
        searchResults.willMove(toParent: nil)
        searchResults.view.removeFromSuperview()
        searchResults.removeFromParent()
        
        addChild(suggests)
        view.addSubview(suggests.view)
        suggests.view.translatesAutoresizingMaskIntoConstraints = false
        
        setupSuggestUI()
        
        suggests.didMove(toParent: self)
    }
    
    func showSearchView() {
        suggests.willMove(toParent: nil)
        suggests.view.removeFromSuperview()
        suggests.removeFromParent()
        
        addChild(self.searchResults)
        view.addSubview(self.searchResults.view)
        searchResults.view.translatesAutoresizingMaskIntoConstraints = false
        
        setupSearchUI()

        searchResults.didMove(toParent: self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateInfo() {
        
    }
    
    private lazy var searchBar: SearchBar = {
        return SearchBar()
    }()
    
    private lazy var suggests: SearchSuggestsViewController = {
        let vc = SearchSuggestsViewController()
        
        vc.viewModel = viewModel
        
        return vc
    }()
    
    private lazy var searchResults: SearchResultsViewController = {
        let vc = SearchResultsViewController()
        vc.viewModel = viewModel
        
        return vc
    }()
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
