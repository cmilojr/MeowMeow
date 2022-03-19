//
//  BreedsModel.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import Foundation

struct BreedsModel: Codable {
    var weight: CatWeight
    var id: String
    var name: String
    var temperament: String
    var origin: String
    var description: String
    var life_span: String
    var image: CatImage
}

struct CatWeight: Codable {
    var metric: String
}

struct CatImage: Codable {
    var url: String
}
