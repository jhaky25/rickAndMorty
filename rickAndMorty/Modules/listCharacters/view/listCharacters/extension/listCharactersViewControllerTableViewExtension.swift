//
//  listCharactersViewControllerTableViewExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

// MARK: - UITableViewDelegate
extension listCharactersViewController: UITableViewDelegate, UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let character = viewModel.characters[indexPath.row]
            coordinator.openCharacterDetail(character: character)
        }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let threshold = viewModel.characters.count - 5
        if indexPaths.contains(where: { $0.row >= threshold }) {
            viewModel.loadCharacters()
        }
    }
}

extension listCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: characterCell.identifier, for: indexPath) as! characterCell
        cell.configure(with: character)
        cell.accessibilityIdentifier = "characterCell_\(character.id)"
        return cell
    }
}
