//
//  characterMapViewControllerMapViewDelegate.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import MapKit

extension characterMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let ann = annotation as? CharacterAnnotation else { return nil }

        let id = "characterPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView

        if view == nil {
            view = MKMarkerAnnotationView(annotation: ann, reuseIdentifier: id)
            view?.canShowCallout = false
            view?.markerTintColor = .systemGreen
            view?.glyphImage = UIImage(systemName: "person.fill")
        }

        view?.annotation = ann
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let ann = view.annotation as? CharacterAnnotation else { return }
        coordinator.openBottomSheet(for: ann.character)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        coordinator.openCharacterDetail(character)
    }

}
