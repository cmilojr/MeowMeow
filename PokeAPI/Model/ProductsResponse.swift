//
//  itemsResponse.swift
//  iBuy
//
//  Created by Camilo Jimenez on 10/08/21.
//

import Foundation

struct ProductsResponse: Decodable {
    let results: [ProductResponse]
}

struct ProductResponse: Decodable {
    let id: String?
    let title: String?
    let price: Double?
    let condition: String?
    let shipping: Shipping
    let original_price: Double?
    let thumbnail: String?
    let accepts_mercadopago: Bool?
    let category_id: String?
}

struct Shipping: Decodable {
    let free_shipping: Bool?
}
