//
//  characterDetailViewControllerValidationExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

extension characterDetailViewController {
    
    func configureCharacter() {
        let character = viewModel.getCharacter()
        nameLabel.text = character.name
        infoLabel.text = "\(character.status) • \(character.species) • \(character.gender)"
        locationLabel.text = "Última ubicación: \(character.location.name)"
        
        imageCancellable = ImageLoader.shared.loadImage(from: character.image)
            .sink { [weak self] img in
                self?.avatarImageView.image = img
            }
    }

    func updateTableHeight() {
        episodesTable.layoutIfNeeded()
        tableHeightConstraint?.constant = episodesTable.contentSize.height
    }
    
    func updateFavoriteButton(value: Bool) {
        favoriteButton.setTitle(
            value ? "Favorito" : "Marcar favorito",
            for: .normal
        )
    }
}
