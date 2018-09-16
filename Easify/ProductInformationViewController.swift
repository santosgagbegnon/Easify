//
//  ProductInformationViewController.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
import UIKit

class ProductInformationViewController : UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productInformationTextView: UITextView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    public var productImage : UIImage! //TO DO: Add default image
    public var product : Product!
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        productImageView.image = productImage
        productNameLabel.text = product.title
        productInformationTextView.text = text()
    }
    private func text() -> String{
//        -body_html: Description
//        -product type
//        -upload date
//        -tags
//        -vendor
//        -id
//        -number of variants
        let description = product.body_html ?? ""
        let productType = product.productType ?? ""
        let uploadDate = product.updated_at ?? ""
        let tags = product.tags ?? ""
//        let vendor = product.vendor ?? ""
//        let id = String(product.id ??  -1)
//        let numofVariants = product.variants?.count ?? 0
        return description + productType + "\n" + uploadDate + "\n" + tags
 
    }
    
    
    
}
