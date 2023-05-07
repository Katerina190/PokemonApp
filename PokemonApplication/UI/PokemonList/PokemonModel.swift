//
//  ListPokemons.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 6.05.23.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonList]
}

struct PokemonList: Codable {
    let name: String
    let url: String
}
