//
//  characterMapSheetViewController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import Combine

final class characterMapSheetViewController: UIViewController {

    let viewModel: CharacterMapSheetViewModel
    var cancellables = Set<AnyCancellable>()

    // MARK: - UI
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        speciesLabel.textColor = .secondaryLabel
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        statusLabel.textColor = .secondaryLabel
        return label
    }()

    init(viewModel: CharacterMapSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSheet()
        setupUI()
        bindViewModel()
    }
}
