//
//  PokemonListPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation


class PokemonListPresenter {
    
    private weak var view: PokemonListViewProtocol?
    private let networkService: ServiceProtocol
    var pokemons: [PokemonList] = []
    
    init(view: PokemonListViewProtocol, networkService: ServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadPokemons() {
        networkService.loadPokemons { [weak self] pokemonModel in
            self?.pokemons = pokemonModel.results
            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
        }
    }
    
    func numberOfRows() -> Int {
        return pokemons.count
    }
    
    func pokemon(at index: Int) -> PokemonList {
        return pokemons[index]
    }
}

