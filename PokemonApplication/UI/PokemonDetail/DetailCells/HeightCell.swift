//
//  HeightCell.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 14.05.23.
//

import UIKit

class HeightCell: UICollectionViewCell {
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightCall: UILabel!

    func config(pokemonHeight: String, call: String) {
        heightLabel.text = "\(pokemonHeight)"
        heightCall.text = "\(call)"
    }
}
