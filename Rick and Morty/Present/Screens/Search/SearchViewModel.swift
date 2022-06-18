//
//  SearchViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.06.2022.
//

import Foundation
import Combine

class SearchViewModel {
    private var characterService: CharacterAPIServiceProtocol
    private var storage: CharacterStorage
    private var cancellableSet: Set<AnyCancellable> = []
    
    weak var coordinator : SearchTabCoordinator!
    
    let searchResults = CurrentValueSubject<[Character], Never>([])
    let recents = CurrentValueSubject<[Character], Never>([])
    
    let searchText = CurrentValueSubject<String, Never>("")
    
    init() {
        characterService = CharacterAPIService()
        storage = CharacterStorageImpl()
        
        searchText.sink {[weak self] text in
            self?.searchCharacters(by: text)
        }
        .store(in: &cancellableSet)
        
        reloadSearched()
    }
    
    func reloadSearched() {
        recents.send(storage.getCharacters(from: .searched))
    }
    
    func searchCharacters(by query: String) {
        characterService.searchCharacters(query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.searchResults.send([])
                default: break
                }
            }, receiveValue: { [weak self] (response:[CharacterDTO]) in
                self?.searchResults.send(response.map { characterDTO in
                    Character(
                        id: characterDTO.id,
                        image: characterDTO.image,
                        name: characterDTO.name,
                        species: characterDTO.species,
                        gender: Character.Gender(rawValue: characterDTO.gender.rawValue) ?? Character.Gender.unknown,
                        status: Character.Status(rawValue: characterDTO.status.rawValue) ?? Character.Status.unknown,
                        isFavorite: false
                    )
                })
            })
            .store(in: &cancellableSet)
    }
    
    func goToCharacterDetailScreen(character: Character) {
        storage.addCharacter(character, for: .searched)
        reloadSearched()
        coordinator.goToCharacterDetail(character)
    }
}
