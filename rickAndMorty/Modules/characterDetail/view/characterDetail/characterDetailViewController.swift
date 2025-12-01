//
//  characterDetailViewController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit
import Combine

final class characterDetailViewController: UIViewController {
    
     let scrollView = UIScrollView()
     let contentView = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.accessibilityIdentifier = "characterNameLabel"
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var locationLabel: UILabel = {
         let label = UILabel()
         label.numberOfLines = 0
         return label
     }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        button.accessibilityIdentifier = "favoriteButton"
        return button
    }()
    
    lazy var episodesTable: UITableView = {
        let table = UITableView()
        table.accessibilityIdentifier = "episodesTable"
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver en mapa", for: .normal)
        button.accessibilityIdentifier = "mapButton"
        button.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        return button
    }()
    
     var tableHeightConstraint: NSLayoutConstraint?
    
     let viewModel: characterDetailViewModel
     let coordinator: characterDetailCoordinator
     var cancellables = Set<AnyCancellable>()
     var imageCancellable: AnyCancellable?
    
    init(viewModel: characterDetailViewModel, coordinator: characterDetailCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        configureCharacter()
        viewModel.loadEpisodes()
    }
    
    @objc private func toggleFavorite() {
        viewModel.toggleFavorite()
    }
    
    @objc private func openMap() {
        coordinator.openMap(for: viewModel.getCharacter())
    }
}
