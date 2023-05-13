//
//  NetworkService.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 7.05.23.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    private let reachability = NetworkReachabilityManager()
    
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
        
        //MARK: - error: request for data
        guard reachability?.isReachable ?? false else {            
            print("No internet connection")
            return
        }
        AF.request(url).responseData { response in
            guard let httpResponse = response.response else {
                // Обработка ошибки запроса
                print("Request failed")
                return
            }
            guard httpResponse.statusCode == 200 else {
                // Обработка некорректного ответа
                print("Invalid response")
                return
            }
            guard let data = response.data else {
                // Обработка некорректных данных
                print("Invalid data")
                return
            }
        }
    }
    
    func loadPokemonDetails(url: URL, completion: @escaping (PokemonDetailsModel) -> Void) {
        // guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/id")
        // else { return }
        
        var detailRequest = URLRequest(url: url)
        detailRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: detailRequest) { responseData, response, error in
            guard error == nil, let jsonData = responseData, let pokemonDetail = try? JSONDecoder().decode(PokemonDetailsModel.self, from: jsonData) else {
                return
            }
            DispatchQueue.main.async {
                completion(pokemonDetail)
            }
        }.resume()
        
        //MARK: - error: request for data
        guard reachability?.isReachable ?? false else {
            // Обработка отсутствия интернет-соединения
            print("No internet connection")
            return
        }
        AF.request(url).responseData { response in
            guard let httpResponse = response.response else {
                // Обработка ошибки запроса
                print("Request failed")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                // Обработка некорректного ответа
                print("Invalid response")
                return
            }
            
            guard let data = response.data else {
                // Обработка некорректных данных
                print("Invalid data")
                return
            }
        }
    }
    
}
