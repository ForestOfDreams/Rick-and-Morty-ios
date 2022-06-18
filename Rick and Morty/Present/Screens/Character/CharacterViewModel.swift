//
//  CharacterViewModel.swift
//  Rick and Morty
//
//  Created by Vladislav Shchukin on 17.06.2022.
//

import Foundation
import Combine

class CharacterViewModel {
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var storage: CharacterStorage
    
    weak var coordinator : SearchTabCoordinator!
    
    let character: CurrentValueSubject<Character, Never>
    
    init(character: Character) {
        storage = CharacterStorageImpl()
        var dto = character
        dto.isFavorite = storage.getCharacters(from: .favorites).contains(character)
        self.character = CurrentValueSubject<Character, Never>(dto)
    }
    
    func onLikeButtonTap() {
        storage.addOrRemoveCharacter(character.value, for: .favorites)
        character.value.isFavorite.toggle()
    }
}
