//
//  SearchField.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 24.05.2022.
//

import Foundation
import UIKit

class SearchBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.delegate = self
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        addSubview(rect)
        addSubview(icon)
        addSubview(textField)
        
        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.heightAnchor.constraint(equalToConstant: 55),
            
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 6),
        ])
        rect.pin(to: self)
    }
    
    lazy var rect: UIView = {
        let ret = UIView()
        ret.layer.cornerRadius = 10
        ret.layer.borderWidth = 1
        ret.layer.borderColor = UIColor.main.cgColor
        return ret
    }()
    
    lazy var icon: UIImageView = {
        let ret = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        ret.image = image
        ret.tintColor = .main
        return ret
    }()
    
    lazy var textField: UITextField = {
        let ret = UITextField()
        ret.attributedPlaceholder = NSAttributedString(
            string: "Search for character",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.main,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
                        ]
        )
        ret.tintColor = .main
        
        return ret
    }()
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search for character",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondary,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
                        ]
        )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search for character",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.main,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
                        ]
        )
    }
}
