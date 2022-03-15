//
//  File.swift
//  PokeAPI
//
//  Created by Camilo Jiménez on 15/03/22.
//

import Foundation

struct CommentModel: Codable {
    var postId: Int
    var id: Int
    var name: String
    var body: String
}
