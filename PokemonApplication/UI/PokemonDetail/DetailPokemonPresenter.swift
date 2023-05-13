//
//  PokemonDetailPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation

class DetailPokemonPresenter: PokemonDetailPresenterProtocol {
    
    weak var view: DetailPokemonViewProtocol?
    var pokemonDetail: PokemonDetailsModel?
    private let networkService: NetworkServiceProtocol
    private let pokemonURL: String
    
    init(view: DetailPokemonViewProtocol, networkService: NetworkServiceProtocol, pokemonURL: String) {
        self.view = view
        self.networkService = networkService
        self.pokemonURL = pokemonURL
    }
    
    func loadPokemonDetails() {
        guard let url = URL(string: pokemonURL) else { return }
        networkService.loadPokemonDetails(url: url) { [weak self] pokemonDetail in
            self?.pokemonDetail = pokemonDetail
            self?.view?.updateUI()
        }
    }
}
