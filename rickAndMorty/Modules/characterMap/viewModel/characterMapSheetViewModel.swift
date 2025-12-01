//
//  characterMapSheetViewModel.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import Combine

final class CharacterMapSheetViewModel {
    
    private let character: characterModel
    
    @Published private(set) var name: String = ""
    @Published private(set) var species: String = ""
    @Published private(set) var status: String = ""
    
    init(character: characterModel) {
        self.character = character
        loadCharacterData()
    }

    private func loadCharacterData() {
        name = character.name
        species = character.species
        status = character.status
    }
}
