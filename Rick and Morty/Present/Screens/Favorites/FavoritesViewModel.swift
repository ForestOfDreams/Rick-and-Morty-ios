//
//  FavoriteViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.06.2022.
//

import Foundation
import Combine

class FavoritesViewModel {
    weak var coordinator : FavoritesTabCoordinator!
    
    private var storage: CharacterStorage
    
    init() {
        storage = CharacterStorageImpl()
        reloadFavorites()
    }
    
    let favoriteCharacters = CurrentValueSubject<[Character], Never>([])
    
    func goToCharacterDetailScreen(character: Character) {
        coordinator.goToCharacterDetail(character)
    }
    
    func reloadFavorites() {
        favoriteCharacters.send(storage.getCharacters(from: .favorites))
    }
}
