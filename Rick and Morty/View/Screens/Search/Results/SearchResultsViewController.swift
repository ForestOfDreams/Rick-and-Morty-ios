//
//  SearchResultsViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit

final class SearchResultsViewController: UIViewController {
    
    struct Model {
        let cells: [SearchResultTableCell.Model]
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
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    private func updateInfo() {
        
    }
    
    private let model: Model
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        // Можно ли задать это для всего controller?
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
        model.cells.count
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
                name: model.cells[indexPath.item].name,
                type: model.cells[indexPath.item].type,
                imageURL: model.cells[indexPath.item].imageURL
            )
        )
        return cell
    }
}
