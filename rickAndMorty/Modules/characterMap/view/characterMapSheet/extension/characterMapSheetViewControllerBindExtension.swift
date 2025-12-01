//
//  characterMapSheetViewControllerBindExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

extension characterMapSheetViewController {
    
    func bindViewModel() {

        viewModel.$name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.nameLabel.text = text
            }
            .store(in: &cancellables)

        viewModel.$species
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.speciesLabel.text = text
            }
            .store(in: &cancellables)

        viewModel.$status
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.statusLabel.text = text
            }
            .store(in: &cancellables)
    }
}
