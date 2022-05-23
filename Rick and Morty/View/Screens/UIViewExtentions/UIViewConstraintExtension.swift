//
//  UIViewExtension.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 06.05.2022.
//

import Foundation
import UIKit

extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate(pinConstraints(to: view))
    }
    
    func pinSafeArea(to view: UIView) {
        NSLayoutConstraint.activate(pinConstraintsSafeArea(to: view))
    }
    
    func pinConstraintsSafeArea(to view: UIView) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    
    func pinConstraints(to view: UIView) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}
