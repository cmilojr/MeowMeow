//
//  PostModel.swift
//  PokeAPI
//
//  Created by Camilo Jiménez on 15/03/22.
//

import Foundation

struct Post: Codable {
    var userId: Int
    var id: Int
    var body: String
    var title: String
}

