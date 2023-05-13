//
//  DatabaseService.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 13.05.23.
//

import Foundation

import SQLite

class DatabaseService {
    static let shared = DatabaseService()
    private let db: Connection?
    
    private let pokemons = Table("pokemons")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let url = Expression<String>("url")
    
    private let pokemonDetails = Table("pokemonDetails")
    private let weight = Expression<Int>("weight")
    private let height = Expression<Int>("height")
    private let imageUrl = Expression<String>("imageUrl")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            let database = try Connection("\(path)/db.sqlite3")
            db = database
            if (try? database.scalar(pokemons.exists)) == nil && (try? database.scalar(pokemonDetails.exists)) == nil {
                createTable()
            }
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    //MARK: - Creating tables
    func createTable() {
        do {
            try db!.run(pokemons.create { table in
                        table.column(id, primaryKey: true)
                        table.column(name)
                        table.column(url)
                        // добавьте другие столбцы в соответствии с вашей моделью
                    })
            try db!.run(pokemonDetails.create { table in
                        table.column(id, primaryKey: true)
                        table.column(name)
                        table.column(weight)
                        table.column(height)
                        table.column(imageUrl)
                    })
        } catch {
            print("Unable to create table")
        }
    }
    //MARK: - Adding a new entry
    func addPokemon(pokemon: PokemonList) {
        do {
            let insert = pokemons.insert(name <- pokemon.name, url <- pokemon.url)
            try db!.run(insert)
        } catch {
            print("Insert failed")
        }
    }
    func getPokemons() -> [PokemonList] {
        var pokemons = [PokemonList]()
        do {
            for pokemon in try db!.prepare(self.pokemons) {
                // Создайте экземпляр PokemonList и добавьте его в массив
                let pokemon = PokemonList(name: pokemon[name], url: pokemon[url])
                pokemons.append(pokemon)
            }
        } catch {
            print("Select failed")
        }
        return pokemons
    }
    //MARK: - Adding and updating a table pokemonDetails table
    func addPokemonDetail(pokemonDetail: PokemonDetailsModel) {
        guard let db = self.db else { return }
        let details = pokemonDetails.filter(id == pokemonDetail.id)
        do {
            if try db.scalar(details.exists) {
                try db.run(details.update(
                    id <- pokemonDetail.id,
                    name <- pokemonDetail.name,
                    weight <- pokemonDetail.weight,
                    height <- pokemonDetail.height,
                    imageUrl <- pokemonDetail.sprites.frontDefault ?? ""
                ))
            } else {
                try db.run(pokemonDetails.insert(
                    id <- pokemonDetail.id,
                    name <- pokemonDetail.name,
                    weight <- pokemonDetail.weight,
                    height <- pokemonDetail.height,
                    imageUrl <- pokemonDetail.sprites.frontDefault ?? ""
                ))
            }
        } catch {
            print("Error saving pokemon detail: \(error)")
        }
    }
    //MARK: - getting details from pokemonDetails table
    func getPokemonDetail(id: Int) -> PokemonDetailsModel? {
        guard let db = self.db else { return nil }
        let details = pokemonDetails.filter(self.id == id)
        do {
            if let detail = try db.pluck(details) {
                let name = detail[self.name]
                let weight = detail[self.weight]
                let height = detail[self.height]
                let imageUrl = detail[self.imageUrl]
                
                let sprites = Sprites(frontDefault: imageUrl)
                let pokemonDetail = PokemonDetailsModel(id: 0, name: name, sprites: sprites, types: [], weight: weight, height: height)
                return pokemonDetail
            }
        } catch {
            print("Error retrieving pokemon detail: \(error)")
        }
        return nil
    }
}
