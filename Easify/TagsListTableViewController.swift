//
//  ViewController.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit

class TagsListTableViewController: UITableViewController{
    
    private var listOfTags = [String]()
    private var tagsListModel = TagsListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.black
        tagsListModel.fetchShopifyProducts { (tags) in
            self.listOfTags = Array(tags)
            self.listOfTags.sort()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTags.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tagCell")
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = "#"+listOfTags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStoryboard.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsCollectionViewController
        let currentTag = listOfTags[indexPath.row].replacingOccurrences(of: "#", with: "") //revert tag back to name
        destinationVC.navigationItem.title = currentTag
        destinationVC.products = tagsListModel.getProductsWithTag(tag: currentTag)
        self.navigationController?.pushViewController(destinationVC, animated: false)
        
    }
}

