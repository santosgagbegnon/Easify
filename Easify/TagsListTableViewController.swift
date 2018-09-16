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
}

