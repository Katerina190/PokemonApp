//
//  ServiceProtocol.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadPokemons(url: URL, completion: @escaping(PokemonModel) -> Void)
    func loadPokemonDetails(url: URL, completion: @escaping(PokemonDetailsModel) -> Void)
}
