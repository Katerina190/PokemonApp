//
//  ViewController.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 5.05.23.
//

import UIKit

protocol PokemonListViewProtocol: AnyObject {
    func reloadData()
}

class ListPokemonVC: UIViewController, PokemonListViewProtocol  {
    
    private var presenter: PokemonListPresenter!
    
    @IBOutlet private weak var pokemonTableView: UITableView!
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            pokemonTableView.dataSource = self
            pokemonTableView.delegate = self

            let networkService = NetworkService()
            presenter = PokemonListPresenter(view: self, networkService: networkService)
            presenter.loadPokemons()
        }
        
        func reloadData() {
            pokemonTableView.reloadData()
        }

    
}


extension ListPokemonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = presenter.pokemon(at: indexPath.row)
        cell.textLabel?.text = pokemon.name
        return cell
    }
}
