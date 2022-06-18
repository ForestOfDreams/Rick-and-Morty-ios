//
//  File.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 29.04.2022.
//

import Foundation
import UIKit

final class CharacterTitleView: UIView {
    
    struct Model {
        let name: String
        let isFavorite: Bool
    }
    
    var onLikeButtonTap: () -> ()
    
    init(onLikeButtonTap: @escaping () -> ()) {
        self.onLikeButtonTap = onLikeButtonTap
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(with model: Model) {
        nameLabel.text = model.name
        favoriteButton.isSelected = model.isFavorite
    }
    
    private func setup() {
        addSubview(nameLabel)
        addSubview(favoriteButton)
        
        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private lazy var nameLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 34)
        ret.textColor = .main
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var favoriteButton: UIButton = {
        let ret = FavoriteButton()
        let normalImage = UIImage(systemName: "heart")
        ret.setImage(normalImage, for: .normal)
        let highlightedImage = UIImage(systemName: "heart.fill")
        ret.setImage(highlightedImage, for: .selected)
        ret.backgroundColor = .greyBG
        ret.tintColor = .main
        ret.widthAnchor.constraint(equalToConstant: 48).isActive = true
        ret.heightAnchor.constraint(equalToConstant: 48).isActive = true
        ret.layer.cornerRadius = 24
        
        ret.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        return ret
    }()
    
    @objc func buttonClicked() {
        onLikeButtonTap()
    }
}

final class FavoriteButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if newValue {
                backgroundColor = .main
                tintColor = .greyBG
            }
            else {
                backgroundColor = .greyBG
                tintColor = .main
            }
            super.isSelected = newValue
        }
    }
}
