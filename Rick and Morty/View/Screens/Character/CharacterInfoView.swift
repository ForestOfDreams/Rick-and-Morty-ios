//
//  CharacterInfoView.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 28.04.2022.
//

import Foundation
import UIKit

// : UIView или UIStackView
final class InfoCell: UIView {
    
    struct Model {
        let key: String
        let value: String
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(with model: Model) {
        infoKeyLabel.text = model.key
        infoValueLabel.text = model.value
    }
    
    private func setup() {
        addSubview(stack)
        addSubview(separator)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        stack.pin(to: self)
        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: topAnchor),
//            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
//            stack.leftAnchor.constraint(equalTo: leftAnchor),
//            stack.rightAnchor.constraint(equalTo: rightAnchor),
            separator.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8),
            separator.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private lazy var stack: UIStackView = {
        let ret = UIStackView()
        ret.alignment = .fill
        ret.distribution = .fill
        ret.contentMode = .left
        ret.axis = .vertical
        ret.spacing = 0
    
        ret.addArrangedSubview(infoKeyLabel)
        ret.addArrangedSubview(infoValueLabel)
//        ret.addArrangedSubview(separator)
        return ret
    }()
    
    private lazy var infoKeyLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .secondary
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var infoValueLabel: UILabel = {
        let ret = UILabel()
        ret.font = .boldSystemFont(ofSize: 22)
        ret.textColor = .main
        ret.numberOfLines = 1
        return ret
    }()
    
    private lazy var separator: RowSeparator = {
        let ret = RowSeparator()
        return ret
    }()
}
