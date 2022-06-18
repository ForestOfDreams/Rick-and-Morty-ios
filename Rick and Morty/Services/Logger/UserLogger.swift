//
//  UserLogger.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

final class UserLogger {
    let logger: Logger
    
    private init() {
        let fileWriter = FileWriter()
        let consoleWriter = ConsoleWriter()
        logger = Logger(writers: [fileWriter, consoleWriter], minLevel: Level.info)
    }
    
    static let shared = UserLogger()
    
    func log(test: String, level: Level) {
        logger.log(level: level, messages: test)
    }
}
