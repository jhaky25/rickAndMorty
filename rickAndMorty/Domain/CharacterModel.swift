//
//  CharacterModel.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 29/11/25.
//

import UIKit

struct characterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let location: locationModel
    let episode: [String]
}

struct charactersResponseModel: Decodable {
    let info: infoModel
    let results: [characterModel]
}

struct infoModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct episodeModel: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
}

struct locationModel: Decodable {
    let name: String
}

struct episodeDisplayModel {
    let id: Int
    let name: String
    let air_date: String
    let code: String
    var watched: Bool
}
