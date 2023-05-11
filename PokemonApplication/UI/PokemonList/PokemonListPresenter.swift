//
//  PokemonListPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation

final class PokemonListPresenter: PokemonListPresenterProtocol {
    
    var pokemons: [PokemonList] = []
    var nextURL: String = "https://pokeapi.co/api/v2/pokemon"
    private weak var view: PokemonListViewProtocol?
    private let networkService: NetworkServiceProtocol

    init(view: PokemonListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadPokemons() {
        guard let url = URL(string: nextURL) else { return }
        networkService.loadPokemons(url: url) { [weak self] pokemonModel in
            self?.nextURL = pokemonModel.next
            self?.pokemons.append(contentsOf: pokemonModel.results)
            DispatchQueue.main.async {
                self?.view?.reloadData()
            }
        }
    }
    
    func pokemon(at index: Int) -> PokemonList {
        return pokemons[index]
    }
  
    func numberOfRows() -> Int {
        return pokemons.count
    }
}

