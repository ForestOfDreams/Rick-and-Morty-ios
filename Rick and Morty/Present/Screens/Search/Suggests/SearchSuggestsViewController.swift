//
//  SearchViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 29.04.2022.
//

import Foundation
import UIKit
import Combine

final class SearchSuggestsViewController: UIViewController {
    
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
        tableView.keyboardDismissMode = .onDrag
        setupUI()
        
        viewModel.recents.sink(receiveValue: {[weak self]_ in
            self?.tableView.reloadData()
        })
        .store(in: &subscriptions)
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        
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
        ret.register(
            SearchSuggestsTableCell.self,
            forCellReuseIdentifier: SearchSuggestsTableCell.defaultReusableIdentifier
        )
        return ret
    }()
}

extension SearchSuggestsViewController: UITableViewDelegate {
}

extension SearchSuggestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchSuggestsTableCell.defaultReusableIdentifier,
            for: indexPath
        ) as? SearchSuggestsTableCell else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel
        
        cell.update(
            with: SearchSuggestsTableCell.Model(
                title: "Recents"
            )
        )
        
        viewModel.recents.sink(receiveValue: {[weak self]_ in
            cell.collectionView.reloadData()
        })
        
        .store(in: &subscriptions)
        
        return cell
    }
}
