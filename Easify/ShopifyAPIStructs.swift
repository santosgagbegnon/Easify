//
//  ShopifyAPIStructs.swift
//  Easify
//  This file contains all the necessary structs to decode the product data from the Shopify Products API
//  Created by Santos on 2018-09-16.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
struct Option : Decodable {
    let id: Int?
    let name : String?
    let position : Int?
    let product_id : Int?
    let values : [String]?
}
struct Product : Decodable {
    let admin_graphql_api_id : String?
    let body_html : String?
    let created_at : String?
    let handle : String?
    let id : Int?
    let images : [ProductImage]?
    let image : ProductImage?
    let options : [Option]?
    let productType : String?
    let published_at : String?
    let published_scope : String?
    let tags : String?
    let template_suffix : String?
    let title: String?
    let updated_at: String?
    let variants: [ProductVariant]?
    let vendor : String?
}

struct ProductImage : Decodable {
    let admin_graphql_api_id : String?
    let alt : String?
    let created_at : String?
    let id : Int?
    let position : Int?
    let product_id : Int?
    let variant_ids : [Int]?
    let src : String?
    let width : Int?
    let height : Int?
    let updated_at : String?
}
struct Products : Decodable {
    let products : [Product]?
}
struct ProductVariant : Decodable {
    let admin_graphql_api_id : String?

    let barcode : String?
    let compare_at_price : String?
    let created_at : String?
    let delayed_sellable_online_quantity : Int?
    let fulfillment_service : String?
    let grams : Int?
    let id : Int?
    let image_id : Int?
    let inventory_item_id : Int?
    let inventory_management : String?
    let inventory_policy : String?
    let inventory_quantity : Int?
    let old_inventory_quanity : Int?
    let option1 : String?
    let option2: String?
    let option3: String?
    let position : Int?
    let price : String?
    let product_id : Int?
    let requires_shipping : Bool?
    let sku : String?
    let taxable : Bool?
    let title : String?
    let updated_at : String?
    let weight : Double?
    let weight_unit : String?

}
