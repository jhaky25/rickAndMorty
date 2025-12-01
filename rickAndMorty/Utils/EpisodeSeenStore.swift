//
//  EpisodeSeenStore.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

final class EpisodeSeenStore {
    static let shared = EpisodeSeenStore()
    private let defaults = UserDefaults.standard
    
    func isEpisodeSeen(_ id: Int) -> Bool {
        defaults.bool(forKey: "episode_\(id)")
    }
    
    func setEpisodeSeen(_ id: Int, seen: Bool) {
        defaults.set(seen, forKey: "episode_\(id)")
    }
}
