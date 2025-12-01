//
//  listCharactersViewControllerUIExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

extension listCharactersViewController {
    
    func setupUI() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        setupFilters()
        setupTableView()
        setupSpinner()
        setupEmptyLabel()
        
    }
    
    // MARK: - Configuracion de filtros
    private func setupFilters() {
        let filterStack = UIStackView(arrangedSubviews: [statusSegment, speciesSegment])
        filterStack.axis = .vertical
        filterStack.spacing = 8
        filterStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterStack)

        NSLayoutConstraint.activate([
            filterStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            filterStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        statusSegment.selectedSegmentIndex = 0
        speciesSegment.selectedSegmentIndex = 0

        statusSegment.addTarget(self, action: #selector(statusChanged), for: .valueChanged)
        speciesSegment.addTarget(self, action: #selector(speciesChanged), for: .valueChanged)
    }
    
    // MARK: - Configuracion de tabla
    private func setupTableView() {
        charactersTable.register(characterCell.self, forCellReuseIdentifier: characterCell.identifier)
        
        charactersTable.dataSource = self
        charactersTable.delegate = self
        
        charactersTable.translatesAutoresizingMaskIntoConstraints = false
        
        
        charactersTable.refreshControl = refreshCharacters

        view.addSubview(charactersTable)

        NSLayoutConstraint.activate([
            charactersTable.topAnchor.constraint(equalTo: speciesSegment.bottomAnchor, constant: 10),
            charactersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Spinner
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Aviso vacio
    private func setupEmptyLabel() {
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
