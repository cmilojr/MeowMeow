//
//  GenerationsModel.swift
//  PokeAPI
//
//  Created by Camilo Jimenez on 10/09/21.
//

import Foundation

struct GenerationsModel: Decodable {
    let results: [Description]
}

struct Description: Decodable {
    let name: String
    let url: String
}

struct PokemonGeneration: Decodable {
    let id: Int
    let pokemon_species: [Description]
}
