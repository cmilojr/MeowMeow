//
//  CommentModel.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

struct CommentModel: Codable {
    var postId: Int
    var id: Int
    var name: String?
    var email: String?
    var body: String?
}
