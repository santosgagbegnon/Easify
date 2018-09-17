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
    @IBOutlet  var productInfoViewCenterToSuperViewY: NSLayoutConstraint!
    @IBOutlet  var productInfoViewCenterToSuperViewX: NSLayoutConstraint!
    @IBOutlet  var productInfoViewEqualHeightToSuperView: NSLayoutConstraint!
    @IBOutlet  var productInfoViewEqualWidthToSuperView: NSLayoutConstraint!
    public var cell : ProductCollectionViewCell!
    public var productImage : UIImage! //TO DO: Add default image
    public var product : Product!
    override func viewDidLayoutSubviews() {
        productInformationTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
            self.toggleProductInfoViewConstraints(disableConstraints: false)
        }, completion: {(_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.productImageView.alpha = 1
                self.productNameLabel.alpha = 1
                self.productInformationTextView.alpha = 1
            }, completion: nil)
        })
    }
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        productImageView.image = productImage
        productNameLabel.text = product.title
        productInformationTextView.attributedText = getAllText()

    }
    private func getAllText() -> NSMutableAttributedString{
        let text = NSMutableAttributedString (string: "")
        //TO DO: ADD TOTAL QUANTITY
        guard let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 17) else {return text}
        guard let regularFont = UIFont(name: "HelveticaNeue", size: 15 ) else {return text}
        let subtitle = ["Quantity: ","Descrption: ","Product Type: ", "Upload Date: ", "Tags: ","Vendor: ","ID: ","Number of Variants: "]
        let information = [String(product.total_quantity ?? 0),product.body_html ,product.product_type ,product.updated_at ,product.tags,product.vendor  ,String(product.id ??  -1),String(product.variants?.count ?? 0)]
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
        let senderView = sender.view!
        senderView.center.y = senderView.center.y + sender.translation(in: senderView).y
        if (sender.state == UIGestureRecognizerState.cancelled) {
            senderView.center = self.view.superview!.center
        }
        if (sender.state == UIGestureRecognizerState.ended){
            UIView.animate(withDuration: 0.5, animations: {
                senderView.transform = CGAffineTransform(translationX: 0, y: -100)
                senderView.alpha = 0
            }) { (_) in
                self.dismiss(animated: false, completion: nil)
            }
        }
        


    }
    private func toggleProductInfoViewConstraints(disableConstraints : Bool){
        if (disableConstraints){
            productInfoViewEqualHeightToSuperView.isActive = false
            productInfoViewCenterToSuperViewY.isActive = false
            productInfoViewCenterToSuperViewX.isActive = false
            productInfoViewEqualWidthToSuperView.isActive = false
        }
        else{
            self.productInfoViewEqualHeightToSuperView.isActive = true
            self.productInfoViewCenterToSuperViewY.isActive = true
            self.productInfoViewCenterToSuperViewX.isActive = true
            self.productInfoViewEqualWidthToSuperView.isActive = true
        }
        self.productInformationView.layoutIfNeeded()
    }
}

extension UIView {
    func addBasicGraidentBackground(firstColour : UIColor, secondColour: UIColor, locations : [NSNumber]){
        let viewGradientLayer = CAGradientLayer()
        viewGradientLayer.frame = self.bounds
        viewGradientLayer.colors = [firstColour.cgColor,secondColour.cgColor]
        viewGradientLayer.locations = locations
        self.layer.insertSublayer(viewGradientLayer, at: 0)
    }
}
