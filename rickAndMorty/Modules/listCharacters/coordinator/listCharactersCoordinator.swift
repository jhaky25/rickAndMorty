//
//  listCharactersCoordinator.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

final class listCharactersCoordinator {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() -> UIViewController {
        let viewModel = listCharactersViewModel()
        let vc = listCharactersViewController(viewModel: viewModel, coordinator: self)
        return vc
    }

    func openCharacterDetail(character: characterModel) {
        let detailCoordinator = characterDetailCoordinator(navigation: navigation, character: character)
        detailCoordinator.start()
    }
}
