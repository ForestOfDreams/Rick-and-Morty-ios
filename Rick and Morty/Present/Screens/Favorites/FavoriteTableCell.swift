//
//  FavoriteCell.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation
import UIKit

final class FavoriteTableCell: UITableViewCell {
    
    struct Model {
        let name: String
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
        self.backgroundColor = .BG
        self.selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterImage)
        contentView.addSubview(rowSeparator)
        
        contentView.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -23),
            characterImage.widthAnchor.constraint(equalToConstant: 100),
            characterImage.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            
            rowSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rowSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func update(with model: Model) {
        nameLabel.text = model.name
        characterImage.kf.setImage(with: model.imageURL)
    }
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .main
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
