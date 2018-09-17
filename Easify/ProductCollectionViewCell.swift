//
//  ProductTableViewCell.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    func addBasicGraidentBackground(firstColour : UIColor, secondColour: UIColor, locations : [NSNumber]){
        let cellGradientLayer = CAGradientLayer()
        cellGradientLayer.frame = self.bounds
        cellGradientLayer.colors = [firstColour.cgColor,secondColour.cgColor]
        cellGradientLayer.locations = locations
        self.layer.insertSublayer(cellGradientLayer, at: 0)
    }
}
