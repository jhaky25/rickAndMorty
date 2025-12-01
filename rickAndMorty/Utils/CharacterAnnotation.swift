//
//  CharacterAnnotation.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import MapKit

final class CharacterAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let character: characterModel
    var title: String?
    var subtitle: String?
    
    init(character: characterModel, coordinate: CLLocationCoordinate2D) {
        self.character = character
        self.coordinate = coordinate
        self.title = character.name
        self.subtitle = character.species
    }
}
