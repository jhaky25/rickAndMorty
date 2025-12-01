//
//  favoritesListViewControllerTableViewExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

extension favoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! characterCell
        let character = viewModel.favorites[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
//    // Eliminar
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            let character = viewModel.favorites[indexPath.row]
//            viewModel.removeFavorite(character)
//        }
//    }
//
//    // Ir al detalle
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let character = viewModel.favorites[indexPath.row]
//        coordinator.openCharacterDetail(character: character)
//    }
}
