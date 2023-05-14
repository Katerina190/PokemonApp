//
//  TypeCell.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 14.05.23.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeCall: UILabel!

    func config(pokemonType: String, call: String) {
        typeLabel.text = "\(pokemonType)"
        typeCall.text = "\(call)"
    }
}


