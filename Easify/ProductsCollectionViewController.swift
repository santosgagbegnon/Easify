//
//  ProductsCollectionViewController.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
import UIKit

class ProductsCollectionViewController : UICollectionViewController {
    public var products = [Product]()
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.layer.cornerRadius = 6
        if let imageURL = URL(string: products[indexPath.row].image?.src ?? "") {
            let downloadImageTask = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let productImage = UIImage(data: data ?? Data()) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = productImage
                    }
                }
            }
            downloadImageTask.resume()
        }
        cell.productNameLabel.text = products[indexPath.row].title ?? "Unkown"
        cell.productQuantityLabel.text = "Quantity: " + String(products[indexPath.row].total_quantity ?? 0)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStoryboard.instantiateViewController(withIdentifier: "ProductInformationVC") as! ProductInformationViewController
        let currentCell = collectionView.cellForItem(at: indexPath) as! ProductCollectionViewCell
        destinationVC.productImage = currentCell.productImageView.image
        destinationVC.product = products[indexPath.row]
        //currentCell.isHidden = true
        print("Cell after moved", currentCell.center.y)
        
        UIView.animate(withDuration: 0.05, animations: {
            currentCell.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            currentCell.transform = CGAffineTransform(translationX: 0, y: -3)

        }) { (_) in
          

            destinationVC.cell = currentCell

            self.navigationController?.present(destinationVC, animated: false)

        }

    }
}
