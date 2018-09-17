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
    @IBOutlet weak var productInformationView: UIView!
    @IBOutlet  var productInfoViewCenterToSafeAreaY: NSLayoutConstraint!
    @IBOutlet  var productInfoViewCenterToSafeAreaX: NSLayoutConstraint!
    @IBOutlet  var productInfoViewEqualHeightToSuperView: NSLayoutConstraint!
    @IBOutlet  var productInfoViewEqualWidthToSuperView: NSLayoutConstraint!
    public var cell : ProductCollectionViewCell!
    public var productImage : UIImage! //TO DO: Add default image
    public var product : Product!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleProductInfoViewConstraints(disableConstraints: true)
        productInformationView.frame = cell.convert(cell.bounds,to:productInformationView)
        productInformationView.layoutIfNeeded()
        productNameLabel.alpha = 0
        productImageView.alpha = 0
        productInformationTextView.alpha = 0
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
            self.toggleProductInfoViewConstraints(disableConstraints: false)
        }, completion: {(_) in
            UIView.animate(withDuration: 0.4, animations: {
                self.productImageView.alpha = 1
                self.productNameLabel.alpha = 1
                self.productInformationTextView.alpha = 1
            }, completion: { (_) in
                print("setting text")
            })
        })
    }
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        productImageView.image = productImage
        productNameLabel.text = product.title
        productInformationTextView.attributedText = text()

    }
    private func text() -> NSMutableAttributedString{
        let text = NSMutableAttributedString (string: "")
        //TO DO: ADD TOTAL QUANTITY
       
        guard let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 17) else {return text}
        guard let regularFont = UIFont(name: "HelveticaNeue", size: 15 ) else {return text}
        
        let subtitle = ["Descrption: ","Product Type: ", "Upload Date: ", "Tags: ","Vendor: ","ID: ","Number of Variants: "]
        let information = [product.body_html ,product.productType ,product.updated_at ,product.tags,product.vendor  ,String(product.id ??  -1),String(product.variants?.count ?? 0)]
        if subtitle.count != information.count {return text}
        for (index,_) in subtitle.enumerated() {
            let currentBoldString = NSMutableAttributedString(string: subtitle[index], attributes: [NSAttributedStringKey.font:boldFont, NSAttributedStringKey.foregroundColor:UIColor.white])
            text.append(currentBoldString)

            if let currentInfo = information[index] {
                let currentRegString = NSMutableAttributedString(string: currentInfo+"\n\n\n", attributes: [NSAttributedStringKey.font:regularFont, NSAttributedStringKey.foregroundColor:UIColor.white])
                text.append(currentRegString)
            }
            else{
                text.append(NSAttributedString(string: "\n\n\n"))
            }
            
            
        }
       
        return text
    }

    @IBAction func onProductInfoViewPanGesture(_ sender: UIPanGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    private func toggleProductInfoViewConstraints(disableConstraints : Bool){
        if (disableConstraints){
            productInfoViewEqualHeightToSuperView.isActive = false
            productInfoViewCenterToSafeAreaY.isActive = false
            productInfoViewCenterToSafeAreaX.isActive = false
            productInfoViewEqualWidthToSuperView.isActive = false
        }
        else{
            self.productInfoViewEqualHeightToSuperView.isActive = true
            self.productInfoViewCenterToSafeAreaY.isActive = true
            self.productInfoViewCenterToSafeAreaX.isActive = true
            self.productInfoViewEqualWidthToSuperView.isActive = true
        }
        self.productInformationView.layoutIfNeeded()
    }
    
    
}
