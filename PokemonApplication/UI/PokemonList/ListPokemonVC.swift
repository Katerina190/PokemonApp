//
//  ViewController.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 5.05.23.
//

import UIKit

class ListPokemonVC: UIViewController, PokemonListViewProtocol {
    //MARK: - Outlets
    @IBOutlet private weak var pokemonTableView: UITableView!

    private var presenter: ListPokemonPresenter!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let networkService = NetworkService()
            pokemonTableView.dataSource = self
            pokemonTableView.delegate = self
            
            presenter = ListPokemonPresenter(view: self, networkService: networkService)
            presenter.loadPokemons()
        }
    
        func reloadData() {
            pokemonTableView.reloadData()
        }
}
    //MARK: - Extension
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.pokemons.count - 1 {
            presenter.loadPokemons()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "POKEMONS"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = presenter.pokemon(at: indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPokemonVC") as? DetailPokemonVC {
            detailVC.pokemonURL = pokemon.url
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
