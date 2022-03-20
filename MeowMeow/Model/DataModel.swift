//
//  DataModel.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import Foundation

struct DataModel: Codable {
    var catInfo: BreedsModel
    var like: Bool
    var dateInteraction: Date
}
