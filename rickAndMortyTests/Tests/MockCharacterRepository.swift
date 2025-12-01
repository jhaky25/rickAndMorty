//
//  MockCharacterRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import Foundation
import CoreData
import Combine
@testable import rickAndMorty

final class MockCharacterRepository: CharacterRepositoryProtocol {

    var result: Result<[characterModel], Error>?
    
    var receivedPage: Int?
    var receivedName: String?
    var receivedStatus: String?
    var receivedSpecies: String?

    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) -> AnyPublisher<[characterModel], Error> {
        
        receivedPage = page
        receivedName = name
        receivedStatus = status
        receivedSpecies = species

        guard let result else {
            return Fail(error: NSError(domain: "", code: -1))
                .eraseToAnyPublisher()
        }

        switch result {
        case .success(let characters):
            return Just(characters)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()

        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
