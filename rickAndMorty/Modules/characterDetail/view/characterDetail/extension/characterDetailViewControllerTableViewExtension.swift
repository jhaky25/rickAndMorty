//
//  characterDetailViewControllerTableViewExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

extension characterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.episodes.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = viewModel.episodes[indexPath.row]
        let seen = EpisodeSeenStore.shared.isEpisodeSeen(episode.id)

        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! episodeCell
        cell.configure(with: episode, seen: seen)
        
        cell.onSeenToggle = { [weak self] isOn in
            guard let self = self else { return }
            self.viewModel.markEpisodeSeen(episode, seen: isOn)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = viewModel.episodes[indexPath.row]
        let currentSeen = viewModel.isEpisodeSeen(episode)
        
        viewModel.markEpisodeSeen(episode, seen: !currentSeen)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
