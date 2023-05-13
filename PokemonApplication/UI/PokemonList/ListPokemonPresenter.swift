//
//  PokemonListPresenter.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation
import Alamofire

final class ListPokemonPresenter: PokemonListPresenterProtocol {
  
   
    var pokemons: [PokemonList] = []
    var nextURL: String = "https://pokeapi.co/api/v2/pokemon"
    private weak var view: PokemonListViewProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(view: PokemonListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    //MARK: - Loading the list and saving it to the database
    func loadPokemons() {
        if isConnectedToInternet {
            guard let url = URL(string: nextURL) else { return }
            networkService.loadPokemons(url: url) { [weak self] pokemonModel in
                self?.nextURL = pokemonModel.next
                self?.pokemons.append(contentsOf: pokemonModel.results)
                
                // Сохраняем данные в базу данных
                if let pokemons = self?.pokemons {
                    for pokemon in pokemons {
                        DatabaseService.shared.addPokemon(pokemon: pokemon)
                    }
                }
                
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            }
        } else {
            // Загружаем данные из базы данных
            let pokemons = DatabaseService.shared.getPokemons()
            self.pokemons = pokemons
            DispatchQueue.main.async {
                self.view?.showNoInternetAlert()
                self.view?.reloadData()
            }
        }
    }
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    //MARK: - pokemon receiving function
    func pokemon(at index: Int) -> PokemonList {
            return pokemons[index]
        }
        
    func numberOfRows() -> Int {
            return pokemons.count
        }
    }

