//
//  EpisodesRepository.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

protocol EpisodesRepositoryProtocol {
    func fetchEpisodes(urls: [String], completion: @escaping(Result<[episodeModel], Error>) -> Void)
}

final class EpisodesRepository: EpisodesRepositoryProtocol {
    
    func fetchEpisodes(urls: [String], completion: @escaping(Result<[episodeModel], Error>) -> Void) {
        let group = DispatchGroup()
        
        var episodes: [episodeModel] = []
        var errorResponse: Error?
        
        for urlString in urls {
            guard let url = URL(string: urlString) else { continue }
            
            group.enter()
            URLSession.shared.dataTask(with: url) { data, _, error in
                defer { group.leave() }
                
                if let error = error {
                    errorResponse = error
                    return
                }
                
                if let data = data {
                    do {
                        let episode = try JSONDecoder().decode(episodeModel.self, from: data)
                        print("Episodio decodificado: \(episode.id)")
                        episodes.append(episode)
                    } catch {
                        dump("Error decodificando episodio: \(error)")
                    }
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            if let error = errorResponse {
                completion(.failure(error))
            } else {
                completion(.success(episodes.sorted { $0.id < $1.id }))
            }
        }
    }
}
