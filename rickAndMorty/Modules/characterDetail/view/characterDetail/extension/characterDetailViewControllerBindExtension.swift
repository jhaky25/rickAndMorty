//
//  characterDetailViewControllerBindExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit

extension characterDetailViewController {
    func bindViewModel() {
        
        viewModel.$episodes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.episodesTable.reloadData()
                self?.updateTableHeight()
            }
            .store(in: &cancellables)
        
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.updateFavoriteButton(value: value)
            }
            .store(in: &cancellables)
    }
}
