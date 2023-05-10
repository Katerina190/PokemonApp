//
//  PokemonListPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation


final class PokemonListPresenter {
    
    private weak var view: PokemonListViewProtocol?
    private let networkService: NetworkServiceProtocol
    var pokemons: [PokemonList] = []
    var nextURL: String = "https://pokeapi.co/api/v2/pokemon"

    init(view: PokemonListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadPokemons() {
//        let urlString = nextURL ?? "https://pokeapi.co/api/v2/pokemon"
        guard let url = URL(string: nextURL) else { return }
        networkService.loadPokemons(url: url) { [weak self] pokemonModel in
            self?.nextURL = pokemonModel.next
            self?.pokemons.append(contentsOf: pokemonModel.results)
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

