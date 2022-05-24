//
//  SectionViewCell.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 29.04.2022.
//

import Foundation
import UIKit

final class SearchSuggestsTableCell: UITableViewCell {
    // ???
    var showCharacterDetailRequested: (String) -> () = {_ in }
    
    struct Model {
        let title: String
        let collectionCellContent: [SearchSuggestsCollectionCell.Model]
    }
    
    var collectionCellContent: [SearchSuggestsCollectionCell.Model] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .BG
        self.selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            // Можно ли настривать contraint в разных NSLayoutConstraint.activate([])?
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            // Как вычислять размер динамически?
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func update(with model: Model) {
        titleLabel.text = model.title
        collectionCellContent = model.collectionCellContent
    }
    
    private lazy var titleLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 17)
        ret.textColor = .main
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let ret = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ret.backgroundColor = .BG
        ret.showsHorizontalScrollIndicator = false
        
        ret.register(
            SearchSuggestsCollectionCell.self,
            forCellWithReuseIdentifier: SearchSuggestsCollectionCell.defaultReusableIdentifier
        )
        ret.sendSubviewToBack(contentView)
        return ret
    }()
}

extension SearchSuggestsTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}

extension SearchSuggestsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchSuggestsCollectionCell.defaultReusableIdentifier,
            for: indexPath
        ) as? SearchSuggestsCollectionCell else {
            assertionFailure()
            return UICollectionViewCell()
        }

        cell.update(with: collectionCellContent[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCharacterDetailRequested("")
    }
}

extension SearchSuggestsTableCell: UICollectionViewDelegate {
    
}
