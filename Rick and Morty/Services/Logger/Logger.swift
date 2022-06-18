//
//  Logger.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.06.2022.
//

import Foundation

enum Level: Int {
    case info = 0
    case debug = 1
    case warning = 2
    case error = 3
    case fatal = 4
}

protocol LoggerProtocol {
    func log(level: Level, messages: @autoclosure () -> String)
}

protocol Writer {
    func write(message: String)
}
