//
//  LoggerImpl.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

final class Logger: LoggerProtocol {
    private let writers: [Writer]
    private let minLevel: Level
    
    init(writers: [Writer], minLevel: Level) {
        self.writers = writers
        self.minLevel = minLevel
    }
    
    func log(level: Level, messages: @autoclosure () -> String) {
        if level.rawValue >= minLevel.rawValue {
            writers.forEach {
                $0.write(message: messages())
            }
        }
    }
}
