//
//  NetworkService.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func loadPokemons(url: URL, completion: @escaping (PokemonModel) -> Void) {
       // guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            guard error == nil, let jsonData = responseData, let pokemonList = try? JSONDecoder().decode(PokemonModel.self, from: jsonData) else {
                return
            }
                    DispatchQueue.main.async {
                        completion(pokemonList)
                    }
        }.resume()
    }
    
     func loadPokemonDetails(completion: @escaping ([PokemonDetailsModel]) -> Void) {
         guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/{id}/")
         else { return }
         
         var detailRequest = URLRequest(url: url)
         detailRequest.httpMethod = "GET"
         
         URLSession.shared.dataTask(with: detailRequest) { responseData, response, error in
             guard error == nil, let jsonData = responseData, let pokemonDetail = try? JSONDecoder().decode([PokemonDetailsModel].self, from: jsonData) else {
                 return
             }
                     DispatchQueue.main.async {
                         completion(pokemonDetail)
                     }
        }.resume()
    }
    
}

