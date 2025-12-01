//
//  dashboardTabBarCoordinator.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

final class dashboardTabBarCoordinator {
    
    let tabBarController: UITabBarController
    private let charactersNav: UINavigationController
    private let favoritesNav: UINavigationController
    
    init() {
        self.tabBarController = UITabBarController()
        self.charactersNav = UINavigationController()
        self.favoritesNav = UINavigationController()
    }
    
    func start() -> UITabBarController {
        
        // MARK: - Personajes
        let charactersCoordinator = listCharactersCoordinator(navigation: charactersNav)
        let charactersVC = charactersCoordinator.start()
        charactersNav.viewControllers = [charactersVC]
        charactersNav.tabBarItem = UITabBarItem(
            title: "Personajes",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        // MARK: - Favoritos
        let favoritesCoordinator = favoritesListCoordinator(navigation: favoritesNav)
        let favoritesVC = favoritesCoordinator.start()
        favoritesNav.viewControllers = [favoritesVC]
        favoritesNav.tabBarItem = UITabBarItem(
            title: "Favoritos",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        tabBarController.viewControllers = [charactersNav, favoritesNav]
        tabBarController.tabBar.tintColor = .systemBlue
        
        return tabBarController
    }
}
