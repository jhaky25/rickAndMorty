//
//  characterMapViewControllerUIExtension.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import MapKit

extension characterMapViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        title = "Ubicación"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        mapView.delegate = self
        
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mapContainerView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapContainerView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mapContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mapContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mapContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor)
        ])
    }
    
    func configureMap() {
        let coordinate = CLLocationCoordinate2D(latitude: Double(character.id % 90), longitude: Double(character.id % 180))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = character.name
        annotation.subtitle = character.location.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 50000)
        
        mapView.setRegion(region, animated: false)
    }
}
