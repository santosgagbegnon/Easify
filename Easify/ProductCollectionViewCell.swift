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
    override func layoutSubviews() {
        //Add blue-white gradient
        let firstColour = UIColor(named: "OffWhite") ?? UIColor.white
        let secondColour = UIColor(named: "BackgroundBlue") ?? UIColor.blue
        let cellGradientLayer = CAGradientLayer()
        cellGradientLayer.frame = self.bounds
        cellGradientLayer.colors = [firstColour.cgColor,secondColour.cgColor]
        cellGradientLayer.locations = [0,0.95]
        self.layer.insertSublayer(cellGradientLayer, at: 0)
        //Round cell 
        self.layer.cornerRadius = 6
    }
}
