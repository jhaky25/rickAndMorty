//
//  characterMapViewController.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import UIKit
import MapKit

class characterMapViewController: UIViewController {
    
    let mapView = MKMapView()
    
    lazy var mapContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.accessibilityIdentifier = "characterMapView"
        return view
    }()
    
    let character: characterModel
    let coordinator: characterMapCoordinator
    
    init(character: characterModel, coordinator: characterMapCoordinator) {
        self.character = character
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
