//
//  SearchResultTableCell.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit

final class SearchResultTableCell: UITableViewCell {
    
    struct Model {
        let name: String
        let type: String
        let imageURL: URL
    }
    
    var collectionCellContent: [SearchSuggestsCollectionCell.Model] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .BG
        self.selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(characterImage)
        contentView.addSubview(rowSeparator)
        
        contentView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -23),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 49),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 24),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            rowSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rowSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])

        let constraint = characterImage.widthAnchor.constraint(equalToConstant: 120)
        constraint.isActive = true
        
        let constraint2 = characterImage.heightAnchor.constraint(equalToConstant: 160)
        constraint2.isActive = true
    }
    
    func update(with model: Model) {
        nameLabel.text = model.name
        typeLabel.text = model.type
        characterImage.kf.setImage(with: model.imageURL)
    }
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .main
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var typeLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 17)
        ret.textColor = .secondary
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var rowSeparator: RowSeparator = {
        let ret = RowSeparator()
        return ret
    }()
    
    private lazy var characterImage: UIImageView = {
        let ret = BaseImage(frame: .zero)
        return ret
    }()
}
