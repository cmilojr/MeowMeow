//
//  PokemonDetailModel.swift
//  MyMessages
//
//  Created by Camilo Jimenez on 13/09/21.
//

import Foundation

struct PokemonDetailModel: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let moves: [Move]
    let sprites: Sprites
    let types: [Types]
    
    struct Move: Decodable {
        let move: Description
    }


    struct Sprites: Decodable {
        let front_default: String
    }

    struct Types: Decodable {
        let type: Description
    }
}
