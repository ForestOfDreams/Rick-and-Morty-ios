//
//  Se.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit

final class RowSeparator: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        backgroundColor = .main
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
