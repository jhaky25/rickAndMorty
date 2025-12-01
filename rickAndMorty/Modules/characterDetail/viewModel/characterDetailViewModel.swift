//
//  characterDetailViewModel.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine

final class characterDetailViewModel: ObservableObject {
    
    @Published private(set) var episodes: [episodeModel] = []
    @Published private(set) var isFavorite: Bool = false
    
    private let repository: EpisodesRepositoryProtocol
    private let character: characterModel
    
    init(character: characterModel, repository: EpisodesRepositoryProtocol = EpisodesRepository()) {
        self.character = character
        self.repository = repository
        self.isFavorite = FavoritesRepository.shared.isFavorite(character)
    }
    
    func getCharacter() -> characterModel { character }
    
    func loadEpisodes() {
        repository.fetchEpisodes(urls: character.episode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let eps):
                    self?.episodes = eps
                case .failure(let error):
                    print("Error al obtener episodios: \(error)")
                }
            }
        }
    }
    
    // MARK: - Favoritos
    func toggleFavorite() {
        FavoritesRepository.shared.toggleFavorite(character)
        isFavorite = FavoritesRepository.shared.isFavorite(character)
    }
    
    // MARK: - Episodios vistos
    func markEpisodeSeen(_ episode: episodeModel, seen: Bool) {
        EpisodeSeenStore.shared.setEpisodeSeen(episode.id, seen: seen)
        objectWillChange.send()
    }
    
    func isEpisodeSeen(_ episode: episodeModel) -> Bool {
        EpisodeSeenStore.shared.isEpisodeSeen(episode.id)
    }
    
    var isFavoritePublisher: AnyPublisher<Bool, Never> {
        $isFavorite.eraseToAnyPublisher()
    }
}

