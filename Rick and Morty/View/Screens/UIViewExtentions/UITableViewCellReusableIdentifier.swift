//
//  UITableViewCellReusableIdentifier.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 19.05.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var defaultReusableIdentifier: String {
        return String(describing: Self.self)
    }
}
