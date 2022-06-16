//
//  UIImage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 24.05.2022.
//

import Foundation
import UIKit

extension UIImage {
    
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
