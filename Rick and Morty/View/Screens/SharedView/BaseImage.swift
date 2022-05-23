//
//  BaseImage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 06.05.2022.
//

import Foundation
import UIKit

final class BaseImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.main.cgColor
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                layer.borderWidth = 0
            }
            else {
                layer.borderWidth = 1
            }
        }
    }
}
