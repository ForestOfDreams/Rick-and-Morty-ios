//
//  SearchResultsViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit
import Combine

final class SearchResultsViewController: UIViewController {
    
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
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        
        viewModel.searchResults.sink(receiveValue: {[weak self]_ in
            self?.tableView.reloadData()
        })
        .store(in: &subscriptions)
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    private func updateInfo() {
        
    }
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.backgroundColor = .BG
        ret.separatorStyle = .none
        ret.register(SearchResultTableCell.self, forCellReuseIdentifier: SearchResultTableCell.defaultReusableIdentifier)
        return ret
    }()
}

extension SearchResultsViewController: UITableViewDelegate {
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableCell.defaultReusableIdentifier,
            for: indexPath
        ) as? SearchResultTableCell else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.update(
            with: SearchResultTableCell.Model(
                name: viewModel.searchResults.value[indexPath.item].name,
                type: viewModel.searchResults.value[indexPath.item].species,
                imageURL: URL(string: viewModel.searchResults.value[indexPath.item].image)!
            )
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserLogger.shared.log(
            test: "Character with id \(viewModel.searchResults.value[indexPath.item].id) was open from search screen",
            level: .info
        )
        
        viewModel.goToCharacterDetailScreen(character: viewModel.searchResults.value[indexPath.item])
    }
}
