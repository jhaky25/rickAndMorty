//
//  favoritesListCoordinator.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine
import LocalAuthentication

final class favoritesListCoordinator {
    
    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() -> UIViewController {
        let viewModel = favoritesListViewModel()
        let vc = favoritesListViewController(viewModel: viewModel, coordinator: self)
        navigation.pushViewController(vc, animated: false)
        return vc
    }

    func openCharacterDetail(character: characterModel) {
        let detailCoordinator = characterDetailCoordinator(navigation: navigation, character: character)
        detailCoordinator.start()
    }
}
