//
//  MockEpisodesRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit
import Combine
@testable import rickAndMorty

final class MockEpisodesRepository: EpisodesRepositoryProtocol {

    var result: Result<[episodeModel], Error>?

    func fetchEpisodes(urls: [String], completion: @escaping (Result<[episodeModel], Error>) -> Void) {
        if let result {
            completion(result)
        } else {
            completion(.success([]))
        }
    }
}
