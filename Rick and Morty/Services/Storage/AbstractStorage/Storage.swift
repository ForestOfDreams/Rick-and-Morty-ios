//
//  Storage.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 07.06.2022.
//

import Foundation
import SwiftUI

protocol Storage {
    func save<T>(key: String, value: T?)
    func get<T>(key: String) -> T?
}
