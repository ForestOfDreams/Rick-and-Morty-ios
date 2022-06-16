//
//  SearchCellCollectionCell.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 04.05.2022.
//

import Foundation

import UIKit

final class SearchSuggestsCollectionCell: UICollectionViewCell {
    
    struct Model {
        let imageURL: URL
    }

    private let sectionView = UICollectionViewCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .BG
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func update(with model: Model) {
        imageView.kf.setImage(with: model.imageURL)
    }
     
    private lazy var imageView: UIImageView = {
        let ret = BaseImage(frame: .zero)
        return ret
    }()
}

extension UICollectionViewCell {
    static var defaultReusableIdentifier: String {
        return String(describing: Self.self)
    }
}
