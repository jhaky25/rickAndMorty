//
//  listCharactersViewController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 27/11/25.
//

import UIKit
import Combine

final class listCharactersViewController: UIViewController {
    
    // MARK: - UI
    lazy var charactersTable: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "charactersTable"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.prefetchDataSource = self
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Buscar por nombre"
        return searchController
    }()
    
    let statusSegment = UISegmentedControl(items: ["Todos","Alive","Dead","unknown"])
    
    let speciesSegment = UISegmentedControl(items: ["Todos","Human","Alien","Other"])
   
    let spinner = UIActivityIndicatorView(style: .large)
   
    lazy var refreshCharacters: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No hay personajes"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true
        return label
    }()

    var cancellables = Set<AnyCancellable>()

    let viewModel: listCharactersViewModel
    let coordinator: listCharactersCoordinator
    
    init(viewModel: listCharactersViewModel = listCharactersViewModel(),
         coordinator: listCharactersCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Ciclo de vida de la App
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes"
        view.backgroundColor = .systemBackground
        
        setupUI()
        bindViewModel()
        viewModel.loadCharacters(reset: true)
    }

    @objc func statusChanged() {
        viewModel.filterStatus = statusSegment.selectedSegmentIndex == 0 ? nil :
        statusSegment.titleForSegment(at: statusSegment.selectedSegmentIndex)
    }

    @objc func speciesChanged() {
        viewModel.filterSpecies = speciesSegment.selectedSegmentIndex == 0 ? nil :
        speciesSegment.titleForSegment(at: speciesSegment.selectedSegmentIndex)
    }
    
    @objc private func refreshData() {
        viewModel.loadCharacters(reset: true)
    }
}

// MARK: - UISearchBarDelegate
extension listCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchName = searchText.isEmpty ? nil : searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchName = nil
    }
}
