//
//  favoritesListViewController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine

class favoritesListViewController: UIViewController {
    
    // MARK: - UI
    let tableView = UITableView()
    var emptyStateLabel: UILabel?
    
    // MARK: - Dependencies
    let viewModel: favoritesListViewModel
    private let coordinator: favoritesListCoordinator
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewModel: favoritesListViewModel, coordinator: favoritesListCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favoritos"
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.isHidden = true
        emptyStateLabel?.isHidden = true
        
        authenticateUser()
    }
}
