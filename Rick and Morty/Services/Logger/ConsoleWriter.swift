//
//  LoggerImpl.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

final class ConsoleWriter: Writer {
    private let serialQueue = DispatchQueue(label: UUID().uuidString)
    
    func write(message: String) {
        serialQueue.async {
            print(message)
        }
    }
}
