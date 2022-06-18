//
//  FavoritesViewController.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation
import UIKit
import Combine

final class FavoritesViewController: UIViewController {
    
    var viewModel : FavoritesViewModel!
    
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
        
        viewModel.favoriteCharacters.sink(receiveValue: {[weak self] in
            if $0.isEmpty {
                self?.noFavoritesLabel.alpha = 1
            } else {
                self?.noFavoritesLabel.alpha = 0
            }
            self?.tableView.reloadData()
        })
        .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadFavorites()
    }
    
    private func setupUI() {
        view.backgroundColor = .BG
        view.addSubview(tableView)
        view.addSubview(noFavoritesLabel)
        
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.pin(to: view)
        NSLayoutConstraint.activate([
            noFavoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateInfo() {
        
    }
    
    private lazy var tableView: UITableView = {
        let ret = UITableView()
        ret.backgroundColor = .BG
        ret.separatorStyle = .none
        ret.register(FavoriteTableCell.self, forCellReuseIdentifier: FavoriteTableCell.defaultReusableIdentifier)
        return ret
    }()
    
    private lazy var noFavoritesLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .secondary
        ret.numberOfLines = 1
        ret.text = "No favorites yet"
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
        viewModel.favoriteCharacters.value.count
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
            with: FavoriteTableCell.Model(
                name: viewModel.favoriteCharacters.value[indexPath.item].name,
                imageURL: URL(string: viewModel.favoriteCharacters.value[indexPath.item].image)!
            )
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserLogger.shared.log(
            test: "Character with id \(viewModel.favoriteCharacters.value[indexPath.item].id) was open from favorite screen",
            level: .info
        )
        
        viewModel.goToCharacterDetailScreen(
            character: viewModel.favoriteCharacters.value[indexPath.item]
        )
    }
}
