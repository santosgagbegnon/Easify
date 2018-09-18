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
        productImageView.layer.cornerRadius = (productImageView.frame.size.width/2)
        productImageView.layer.borderColor = UIColor.white.cgColor
        productImageView.layer.borderWidth = 7
        productImageView.clipsToBounds = true
        productImageView.contentMode = UIViewContentMode.scaleAspectFill
        productNameLabel.text = product.title
        productInformationTextView.attributedText = getAllText()
    }
    private func getAllText() -> NSMutableAttributedString{
        let text = NSMutableAttributedString (string: "")
        guard let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 17) else {return text}
        guard let regularFont = UIFont(name: "HelveticaNeue", size: 15 ) else {return text}
        let allInformation = ["Quantity":String(product.total_quantity ?? 0),"Description":product.body_html,"Product Type": product.product_type, "Upload Date" : product.updated_at, "Tags": product.tags,"Vendor" : product.vendor, "ID":String(product.id ?? 0),"Number of Variants:":String(product.variants?.count ?? 0)]
        let informationKeys = allInformation.keys.sorted()
        for(_,key) in informationKeys.enumerated() {
            let currentBoldString = NSMutableAttributedString(string: key+": ", attributes: [NSAttributedStringKey.font:boldFont, NSAttributedStringKey.foregroundColor:UIColor.white])
            text.append(currentBoldString)
            if let keyInfo = allInformation[key] {
                if keyInfo == nil {text.append(NSAttributedString(string: ""))}
                let currentRegString = NSMutableAttributedString(string: keyInfo!+"\n\n\n", attributes: [NSAttributedStringKey.font:regularFont, NSAttributedStringKey.foregroundColor:UIColor.white])
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
