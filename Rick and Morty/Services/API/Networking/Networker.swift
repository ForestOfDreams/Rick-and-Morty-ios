//
//  Networker.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation
import Combine

protocol NetworkerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func get(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

final class Networker: NetworkerProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .eraseToAnyPublisher()
    }
}
