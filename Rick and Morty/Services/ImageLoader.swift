//
//  ImageLoader.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.05.2022.
//

import Foundation
import UIKit

protocol ImageLoader {
    func getImage(from url: URL) async throws -> UIImage?
}

class ImageLoaderImpl: ImageLoader {
    func getImage(from url: URL) async throws -> UIImage? {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ImageLoadError()
        }
        guard let image = UIImage(data: data) else {
            throw ImageLoadError()
        }
        return image
    }
}

class ImageLoadError: Error {
    
}
