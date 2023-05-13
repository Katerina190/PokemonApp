//
//  PokemonDetailPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation
import UIKit

class DetailPokemonPresenter: PokemonDetailPresenterProtocol {
    
    weak var view: DetailPokemonViewProtocol?
    var pokemonDetail: PokemonDetailsModel?
    private let networkService: NetworkServiceProtocol
    private let pokemonURL: String
    private let dataProvider: DataProvider
    
    init(view: DetailPokemonViewProtocol, networkService: NetworkServiceProtocol, pokemonURL: String, dataProvider: DataProvider) {
        self.view = view
        self.networkService = networkService
        self.pokemonURL = pokemonURL
        self.dataProvider = dataProvider
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
           dataProvider.loadImage(from: urlString, completion: completion)
       }
    
    func loadPokemonDetails() {
        guard let url = URL(string: pokemonURL) else { return }
        networkService.loadPokemonDetails(url: url) { [weak self] pokemonDetail in
            self?.pokemonDetail = pokemonDetail
            self?.view?.updateUI()
        }
    }
}
