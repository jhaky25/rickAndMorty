//
//  characterDetailCoordinator.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

// MARK: - Coordinator
final class characterDetailCoordinator {
    private let navigation: UINavigationController
    private let character: characterModel
    
    init(navigation: UINavigationController, character: characterModel) {
        self.navigation = navigation
        self.character = character
    }
    
    func start() {
        let viewModel = characterDetailViewModel(character: character)
        let vc = characterDetailViewController(viewModel: viewModel, coordinator: self)
        navigation.pushViewController(vc, animated: true)
    }
    
    func openMap(for character: characterModel) {
        let mapCoordinator = characterMapCoordinator(navigation: navigation, character: character)
        mapCoordinator.start()
    }
}

