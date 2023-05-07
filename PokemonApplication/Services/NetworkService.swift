//
//  NetworkService.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation

 class NetworkService: ServiceProtocol {
    
    func loadPokemons(completion: @escaping (PokemonModel) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let jsonData = responseData {
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonModel.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(pokemonList)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    
    
    
    func loadPokemonDetails(completion: @escaping ([PokemonDetailsModel]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/{id}/")
        else { return }
        
        var detailRequest = URLRequest(url: url)
        detailRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: detailRequest) { responseData, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let jsonData = responseData {
                do {
                    let pokemonDetail = try? JSONDecoder().decode([PokemonDetailsModel].self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(pokemonDetail ?? [])
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
}

