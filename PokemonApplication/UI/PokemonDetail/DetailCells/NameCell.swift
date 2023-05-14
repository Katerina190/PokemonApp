//
//  NameCell.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 14.05.23.
//

import UIKit

class NameCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameCall: UILabel!

    func configure(nameLabel: String, call: String) {
        name.text = "\(nameLabel)"
        nameCall.text = "\(call)"
    }
}


