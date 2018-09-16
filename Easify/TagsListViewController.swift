//
//  ViewController.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit

class TagsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let model = TagsListModel()
        model.fetchShopifyProducts()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

