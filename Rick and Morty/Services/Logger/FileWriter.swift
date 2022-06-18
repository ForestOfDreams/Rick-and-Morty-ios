//
//  FileWriter.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import Foundation

final class FileWriter: Writer {
    private let serialQueue = DispatchQueue(label: UUID().uuidString)
    private let fileURL: URL
    
    init() {
        let documentDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
        fileURL = documentDirectory.appendingPathComponent("loggs.txt")

        FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        print(fileURL.path)
    }
    func write(message: String) {
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            let handle = try! FileHandle(forWritingTo: self.fileURL)
                handle.seekToEndOfFile()
                handle.write(message.data(using: .utf8)!)
                handle.closeFile()
        }
    }
}
