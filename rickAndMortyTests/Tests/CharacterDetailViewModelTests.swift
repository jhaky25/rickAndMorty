//
//  CharacterDetailViewModelTests.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import XCTest
import Combine
@testable import rickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {

    var viewModel: characterDetailViewModel!
    var episodesRepo: MockEpisodesRepository!
    var favRepo: MockFavoritesRepository!
    var cancellables = Set<AnyCancellable>()

    func testToggleFavorite() {
        
        let character = characterModel(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            image: "",
            gender: "Male",
            location: locationModel(name: ""),
            episode: ["1 EP1"]
        )
        
        favRepo = MockFavoritesRepository()
        
        episodesRepo = MockEpisodesRepository()

        viewModel = characterDetailViewModel(character: character, repository: episodesRepo)
        
        let favoriteChanged = expectation(description: "Favorite state changed")
        var receivedValues: [Bool] = []
        
        viewModel.isFavoritePublisher
            .sink { value in
                receivedValues.append(value)

                if receivedValues.count == 2 {
                    favoriteChanged.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.toggleFavorite()
        viewModel.toggleFavorite()
        
        waitForExpectations(timeout: 1)

        XCTAssertEqual(receivedValues, [false, true, false])
        XCTAssertFalse(favRepo.isFavorite(character))
    }
}
