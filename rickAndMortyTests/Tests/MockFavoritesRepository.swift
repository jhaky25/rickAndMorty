//
//  MockFavoritesRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

import Foundation
@testable import rickAndMorty

final class MockFavoritesRepository: FavoritesRepositoryProtocol {

    private(set) var favorites: Set<Int> = []

    func getAllFavorites() -> [characterModel] { [] }

    func toggleFavorite(_ character: characterModel) {
        if favorites.contains(character.id) {
            favorites.remove(character.id)
        } else {
            favorites.insert(character.id)
        }
    }

    func isFavorite(_ character: characterModel) -> Bool {
        favorites.contains(character.id)
    }
}
