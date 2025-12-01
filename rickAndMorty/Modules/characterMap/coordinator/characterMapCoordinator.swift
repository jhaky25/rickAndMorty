//
//  characterMapCoordinator.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

final class characterMapCoordinator {
    
    private let navigation: UINavigationController
    private let character: characterModel

    init(navigation: UINavigationController, character: characterModel) {
        self.navigation = navigation
        self.character = character
    }

    func start() {
        let vc = characterMapViewController(character: character, coordinator: self)
        navigation.pushViewController(vc, animated: true)
    }

    func openCharacterDetail(_ character: characterModel) {
        let detailVM = characterDetailViewModel(character: character)
        let detailVC = characterDetailViewController(
            viewModel: detailVM,
            coordinator: characterDetailCoordinator(
                navigation: navigation,
                character: character
            ))
        navigation.pushViewController(detailVC, animated: true)
    }
    
    func openBottomSheet(for character: characterModel) {
        let sheetVM = CharacterMapSheetViewModel(character: character)
        let sheetVC = characterMapSheetViewController(viewModel: sheetVM)
        navigation.present(sheetVC, animated: true)
    }
}
