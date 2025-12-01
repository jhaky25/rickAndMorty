//
//  favoritesListViewModel.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine

class favoritesListViewModel {
    
    @Published private(set) var favorites: [characterModel] = []
    private(set) var isEmpty: Bool = true

    private let repository: FavoritesRepositoryProtocol

    init(repository: FavoritesRepositoryProtocol = FavoritesRepository.shared) {
        self.repository = repository
    }

    func loadFavorites() {
        favorites = repository.getAllFavorites()
        isEmpty = favorites.isEmpty
    }

    func removeFavorite(_ character: characterModel) {
        repository.toggleFavorite(character)
        loadFavorites()
    }
}
