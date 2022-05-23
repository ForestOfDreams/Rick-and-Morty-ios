//
//  FavoritesViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {
    
    struct Model {
        let cells: [FavoriteTableCell.Model]
    }
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Favorites"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Так ок?
//        title = "Favorites"
//        navigationItem.title = "Favorites"
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        // Лучше не менять navigationBar из viewController?
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    private func updateInfo() {
        
    }
    
    private let model: Model
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.separatorStyle = .none
        // Удаляет separator с первой ячейки
//        ret.tableHeaderView = UIView()
        ret.register(FavoriteTableCell.self, forCellReuseIdentifier: FavoriteTableCell.defaultReusableIdentifier)
        return ret
    }()
}

extension FavoritesViewController: UITableViewDelegate {
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableCell.defaultReusableIdentifier,
            for: indexPath
        ) as? FavoriteTableCell else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.update(
            with: model.cells[indexPath.item]
        )
        
        return cell
    }
}
