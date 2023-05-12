//
//  DetailPokemonVC.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 6.05.23.
//
import Foundation
import UIKit

final class DetailPokemonVC: UIViewController, DetailPokemonViewProtocol  {
    //MARK: - Outlets
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel:UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    
    var pokemonURL: String!
    private var presenter: DetailPokemonPresenter!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailPokemonPresenter(view: self, networkService: NetworkService(), pokemonURL: pokemonURL, dataProvider: DataProvider())
        presenter.loadPokemonDetails()
    }
    //MARK: Function for load image
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                    print("Error loading image: \(error)")
                } 
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    //MARK: - Func for update UI with details
    func updateUI() {
        guard let pokemonDetail = presenter.pokemonDetail else { return }
        nameLabel.text = "Name: \(pokemonDetail.name)"
        
        if let imageUrlString = pokemonDetail.sprites.frontDefault {
                loadImage(from: imageUrlString) { [weak self] image in
                    self?.pokemonImage.image = image
                }
            }
        typeLabel.text = "Type: \(pokemonDetail.types.first?.type.name ?? "no way!")"
        weightLabel.text = "Height: \(pokemonDetail.weight) kg"
        heightLabel.text = "Weight: \(pokemonDetail.height) cm"
    }
}
