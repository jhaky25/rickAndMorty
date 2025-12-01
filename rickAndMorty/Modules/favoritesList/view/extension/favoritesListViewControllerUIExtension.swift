//
//  favoritesListViewControllerUIExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import LocalAuthentication

extension favoritesListViewController {
    
    // MARK: - TableView
    func setupTableView() {
        guard tableView.superview == nil else { return }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(characterCell.self, forCellReuseIdentifier: "characterCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Estado vacio
    func showEmptyState() {
        let label = UILabel()
        label.text = "No hay favoritos aún"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        emptyStateLabel = label
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Biometric
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        let reason = "Accede a tus favoritos con Face ID / Touch ID o el código del dispositivo"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, authError in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if success {
                        self.loadFavorites()
                    } else {
                        let message = authError?.localizedDescription ?? "No se pudo verificar tu identidad"
                        self.showAlert(title: "Autenticación fallida", message: message)
                        
                        self.tableView.isHidden = true
                        self.emptyStateLabel?.isHidden = true
                    }
                }
            }
        } else {
            let message = error?.localizedDescription ?? "Biometría no disponible"
            showAlert(title: "Autenticación no disponible", message: message)
            tableView.isHidden = true
            emptyStateLabel?.isHidden = true
        }
    }
    
    // MARK: - Cargar favoritos
    private func loadFavorites() {
        tableView.isHidden = false
        bindViewModel()
        viewModel.loadFavorites()
    }
    
    // MARK: - Alertas
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
