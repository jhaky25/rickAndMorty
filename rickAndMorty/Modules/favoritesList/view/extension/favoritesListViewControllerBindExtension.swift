//
//  favoritesListViewControllerBindExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import Combine

extension favoritesListViewController {
    
    func bindViewModel() {
        viewModel.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favorites in
                guard let self = self else { return }
                
                self.emptyStateLabel?.removeFromSuperview()
                
                if favorites.isEmpty {
                    self.showEmptyState()
                } else {
                    self.emptyStateLabel?.isHidden = true
                }
                
                self.tableView.isHidden = favorites.isEmpty
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
