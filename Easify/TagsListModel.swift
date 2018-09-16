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
        guard var allProducts = products.products else {return false}
        //Going through products and finding all tags, while only keeping the unique ones.
        for (productIndex,_) in allProducts.enumerated() {
            allProducts[productIndex].total_quantity = calculateTotalQuantity(product: allProducts[productIndex])
            let tags = allProducts[productIndex].tags?.components(separatedBy: ",") ?? []
            for (tagIndex,_) in tags.enumerated() {
                let tag = tags[tagIndex].trimmingCharacters(in: .whitespaces)
                if (allTags[tag] == nil){
                    allTags[tag] = [allProducts[productIndex]]
                }
                else{
                    allTags[tag]?.append(allProducts[productIndex])
                }
                uniqueProductTags.insert(tag)
            }
        }
        return true
    }
    private func calculateTotalQuantity(product : Product) -> Int { //Set total quanity property to a product
        guard let productVariants = product.variants else {return 0}
        var totalQuantity = 0
        for (_,variant) in productVariants.enumerated() {
            if let specificVariantQuantity = variant.inventory_quantity {
                totalQuantity += specificVariantQuantity
            }
        }
        return totalQuantity
    }

    public func getTags() -> Set<String> {
        return uniqueProductTags
    }
    public func getProductsWithTag(tag : String) -> [Product]{
        return allTags[tag] ?? [Product]()
    }
    public func fetchShopifyProducts( closure : @escaping (Set<String>) -> Void) {
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
                    let products = try JSONDecoder().decode(Products.self, from: data)
                    _ = self.determineTags(products: products)
                    closure(self.uniqueProductTags)
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
