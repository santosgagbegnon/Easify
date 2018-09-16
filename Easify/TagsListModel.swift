//
//  TagsListModel.swift
//  Easify
//
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
class TagsListModel {
    private static var SHOPIFY_ACCESS_TOKEN = "c32313df0d0ef512ca64d5b336a0d7c6"
    private var uniqueProductTags = Set<String>()
    private var allTags = [String:[Product]]()
    
    private func determineTags(products : Products) -> Bool{
        guard let products = products.products else {return false}
        //print(products)
        //Going through products and finding all tags, while only keeping the unique ones.
        for (_,product) in products.enumerated() {
            let tags = product.tags?.components(separatedBy: ",") ?? []
            for (index,_) in tags.enumerated() {
                let tag = tags[index].trimmingCharacters(in: .whitespaces)
                if (allTags[tag] == nil){
                    allTags[tag] = [product]
                }
                else{
                    allTags[tag]?.append(product)
                }
                uniqueProductTags.insert(tag)
            }
        }
        let keys = allTags.keys
        for (_,key) in keys.enumerated() {
            guard let productx = allTags[key] else {return false}
            print("KEY: ",key , "\n")
            for (_,it) in productx.enumerated(){
                print(it.image?.src , "\n")

            }
            print("\n\n\n")

        }
        print("Total places",allTags.keys.count)
        return true
    }
    public func fetchShopifyProducts() {
        let baseStringURL = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=" + TagsListModel.SHOPIFY_ACCESS_TOKEN
        guard let requestURL = URL(string: baseStringURL) else {return}
        var x = URLRequest(url:requestURL)
        x.httpMethod = "GET"
        URLSession.shared.dataTask(with: x) { (data, response, error) in
            if (error != nil){
                print("Error fetching Shopify Products:" , error!)
            }
            guard let data = data else {return}
            let httpURLResponse = response as? HTTPURLResponse
            let responseStatusCode = httpURLResponse?.statusCode
            if (responseStatusCode == 200){
                do {
                    //print(String(data: data, encoding: .utf8)!)
                    let products = try JSONDecoder().decode(Products.self, from: data)
                    _ = self.determineTags(products: products)
                }
                catch let JSONParsingError {
                    print("Error parsing Product Json:", JSONParsingError)
                }
            }
            else{
                print("Response code not 200, instead it's: \(responseStatusCode ?? -1)")
            }
        }.resume()
    }
}
