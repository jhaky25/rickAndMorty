//
//  dashboardTabBarController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

class dashboardTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {

        // MARK: - Personajes
        let charactersNav = UINavigationController()
        let charactersCoordinator = listCharactersCoordinator(navigation: charactersNav)
        let charactersVC = charactersCoordinator.start()
        charactersNav.viewControllers = [charactersVC]
        charactersNav.tabBarItem = UITabBarItem(
            title: "Personajes",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        // MARK: - Favoritos
        let favoritesNav = UINavigationController()
        let favoritesCoordinator = favoritesListCoordinator(navigation: favoritesNav)
        let favoritesVC = favoritesCoordinator.start()
        favoritesNav.viewControllers = [favoritesVC]
        favoritesNav.tabBarItem = UITabBarItem(
            title: "Favoritos",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )

        viewControllers = [charactersNav, favoritesNav]
        tabBar.tintColor = .systemBlue
    }
}
