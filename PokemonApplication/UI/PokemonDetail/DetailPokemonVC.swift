//
//  DetailPokemonVC.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 6.05.23.
//
import UIKit

final class DetailPokemonVC: UIViewController, DetailPokemonViewProtocol  {
    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pokemonImage: UIImageView!
    
    var pokemonURL: String!
    private var presenter: DetailPokemonPresenter!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(UINib(nibName: "NameCell", bundle: nil), forCellWithReuseIdentifier: "NameCell")
        collectionView.register(UINib(nibName: "TypeCell", bundle: nil), forCellWithReuseIdentifier: "TypeCell")
        collectionView.register(UINib(nibName: "WeightCell", bundle: nil), forCellWithReuseIdentifier: "WeightCell")
        collectionView.register(UINib(nibName: "HeightCell", bundle: nil), forCellWithReuseIdentifier: "HeightCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        //MARK: - Setup vertical cells
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 70)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        presenter = DetailPokemonPresenter(view: self, networkService: NetworkService(), pokemonURL: pokemonURL, dataProvider: DataProvider())
        presenter.loadPokemonDetails()
    }
    //MARK: - Load images
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                  //  print("Error loading image: \(error)")
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
    //MARK: - Update UI
    func updateUI() {
        guard let pokemonDetail = presenter.pokemonDetail else { return }
        if let imageUrlString = pokemonDetail.sprites.frontDefault {
                loadImage(from: imageUrlString) { [weak self] image in
                    DispatchQueue.main.async {
                        self?.pokemonImage.image = image
                    }
                }
            }
        collectionView.reloadData()
    }
}
//MARK: - Extension
extension DetailPokemonVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemonDetail = presenter.pokemonDetail else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        }

        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameCell", for: indexPath) as! NameCell
            cell.configure(nameLabel: pokemonDetail.name, call: "name:")
            cell.layer.cornerRadius = 20.0
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
            cell.config(pokemonType: (pokemonDetail.types.first?.type.name) ?? "unknown type", call: "type:")
            cell.layer.cornerRadius = 20.0
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeightCell", for: indexPath) as! WeightCell
            cell.config(pokemonWeight: "\(pokemonDetail.weight) kg", call: "weight:")
            cell.layer.cornerRadius = 20.0
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeightCell", for: indexPath) as! HeightCell
            cell.config(pokemonHeight:  "\(pokemonDetail.height) cm", call: "height:")
            cell.layer.cornerRadius = 20.0
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        }
    }

}
        

    
    

