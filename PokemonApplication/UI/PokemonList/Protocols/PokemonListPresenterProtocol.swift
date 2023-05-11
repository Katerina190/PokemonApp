//
//  PokemonListPresenterProtocol.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 12.05.23.
//

import Foundation

protocol PokemonListPresenterProtocol: AnyObject {
    func loadPokemons()
    func pokemon(at index: Int) -> PokemonList
    func numberOfRows() -> Int
}
