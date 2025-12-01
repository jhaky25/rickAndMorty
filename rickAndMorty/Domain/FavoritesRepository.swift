//
//  FavoritesRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit
import CoreData
import Combine

protocol FavoritesRepositoryProtocol {
    func getAllFavorites() -> [characterModel]
    func toggleFavorite(_ character: characterModel)
    func isFavorite(_ character: characterModel) -> Bool
}

final class FavoritesRepository: FavoritesRepositoryProtocol {
    static let shared = FavoritesRepository()
    private let context = PersistenceController.shared.context
    
    @Published private(set) var favoritesUpdated: Bool = false

    func getAllFavorites() -> [characterModel] {
        let fetch: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            return try context.fetch(fetch).map { fav in
                characterModel(
                    id: Int(fav.id ?? "0") ?? 0,
                    name: fav.name ?? "",
                    status: fav.status ?? "",
                    species: fav.species ?? "",
                    image: fav.image ?? "",
                    gender: fav.gender ?? "",
                    location: locationModel(name: fav.location ?? ""),
                    episode: []
                )
            }
        } catch { return [] }
    }

    func toggleFavorite(_ character: characterModel) {
        if isFavorite(character) { removeFavorite(character) } else { saveFavorite(character) }
        favoritesUpdated = true
    }

    func isFavorite(_ character: characterModel) -> Bool {
        let fetch: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %@", "\(character.id)")
        return (try? context.fetch(fetch))?.isEmpty == false
    }

    private func saveFavorite(_ character: characterModel) {
        let fav = FavoriteCharacter(context: context)
        fav.id = "\(character.id)"
        fav.name = character.name
        fav.status = character.status
        fav.species = character.species
        fav.gender = character.gender
        fav.image = character.image
        fav.location = character.location.name
        try? context.save()
    }

    func removeFavorite(_ character: characterModel) {
        let fetch: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %@", "\(character.id)")
        if let results = try? context.fetch(fetch) {
            results.forEach { context.delete($0) }
            try? context.save()
        }
    }
}
