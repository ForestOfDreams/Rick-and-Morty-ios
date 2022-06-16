//
//  CharacterAPIService.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 31.05.2022.
//

import Foundation
import Combine

protocol CharacterAPIServiceProtocol: AnyObject {
    func getAllCharacters() -> AnyPublisher<[CharacterDTO], Error>
}

final class CharacterAPIService: CharacterAPIServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker(session: URLSession(configuration: .default))) {
        self.networker = networker
    }
    
    func getAllCharacters() -> AnyPublisher<[CharacterDTO], Error> {
        let endpoint = Endpoint.getAllCharacters
        
        return networker.get(
            url: endpoint.url,
            headers: [:]
        )
        .tryMap { (data,response) -> Data in
        
            if let error = ServerError(from: response) {
                throw error
            }
            return data
        }
        .decode(type: GetAllCharactersResponse.self, decoder: JSONDecoder())
        .map(\.results)
        .eraseToAnyPublisher()
    }
}

struct GetAllCharactersResponse: Decodable {
    let results: [CharacterDTO]
}
