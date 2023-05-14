//
//  WeightAndHeightCell.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 14.05.23.
//

import UIKit

class WeightCell: UICollectionViewCell {
        
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightCall: UILabel!
        
    func config(pokemonWeight: String, call: String) {
            weightLabel.text = "\(pokemonWeight)"
            weightCall.text = "\(call)"
    }
}


