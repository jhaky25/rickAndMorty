//
//  listCharactersViewControllerBindExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

extension listCharactersViewController {
    
    func bindViewModel() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.charactersTable.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                if loading {
                    self?.spinner.startAnimating()
                } else {
                    self?.spinner.stopAnimating()
                    self?.refreshCharacters.endRefreshing()
                }
            }
            .store(in: &cancellables)

        viewModel.$isEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] empty in
                self?.emptyLabel.isHidden = !empty
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] msg in
                let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
}
