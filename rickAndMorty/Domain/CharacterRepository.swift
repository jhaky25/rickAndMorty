//
//  CharacterRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) -> AnyPublisher<[characterModel], Error>
}

final class CharacterRepository: CharacterRepositoryProtocol {
    
    private let baseURL = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) -> AnyPublisher<[characterModel], Error> {
        var components = URLComponents(string: baseURL)!
        var query: [URLQueryItem] = [URLQueryItem(name: "page", value: "\(page)")]
        
        if let name = name { query.append(URLQueryItem(name: "name", value: name)) }
        if let status = status { query.append(URLQueryItem(name: "status", value: status)) }
        if let species = species { query.append(URLQueryItem(name: "species", value: species)) }
        
        components.queryItems = query
        let url = components.url!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: charactersResponseModel.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
