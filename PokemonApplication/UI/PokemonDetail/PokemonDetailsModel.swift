//
//  Model.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 6.05.23.
//

import Foundation

struct PokemonDetailsModel: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
    let height: Int
}

struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Type
}

struct Type: Codable {
    let name: String
    let url: String
}
