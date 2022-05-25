//
//  SearchViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 29.04.2022.
//

import Foundation
import UIKit

final class SearchSuggestsViewController: UIViewController {
    
    var showCharacterDetailRequested: (String) -> ()
    
    struct Model {
        let cells: [SearchSuggestsTableCell.Model]
    }
    
    init(model: Model, showCharacterDetailRequested: @escaping (String) -> ()) {
        self.model = model
        self.showCharacterDetailRequested = showCharacterDetailRequested
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
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
    }
    
    private func updateInfo() {
        
    }
    
    private let model: Model
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.backgroundColor = .BG
        ret.separatorStyle = .none
        ret.register(SearchSuggestsTableCell.self, forCellReuseIdentifier: SearchSuggestsTableCell.defaultReusableIdentifier)
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
        model.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchSuggestsTableCell.defaultReusableIdentifier,
            for: indexPath
        ) as? SearchSuggestsTableCell else {
            assertionFailure()
            return UITableViewCell()
        }
        cell.showCharacterDetailRequested = showCharacterDetailRequested
        cell.update(
            with: SearchSuggestsTableCell.Model(
                title: model.cells[indexPath.item].title,
                collectionCellContent: model.cells[indexPath.item].collectionCellContent
            )
        )
        return cell
    }
}
