//
//  Constants.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit

struct Constants {
    struct API {
        static let generations = "https://pokeapi.co/api/v2/generation/"
        static let pokemonDetail = "https://pokeapi.co/api/v2/pokemon/"
        static func RandomPokemonList() -> String {
            let limit = Int.random(in: 0..<1119)
            let offset = Int.random(in: 0..<1119)
            return "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        }
    }
    
    struct CellIdentifier {
        static let categoryCell = "CategoryCell"
    }
    
    struct SBIdentifier {
        static let generations = "Generations"
    }

    struct CustomColors {
        static let mintGreen = UIColor(named: "MintGreen")
        static let red = UIColor(named: "Red")
        static let softPurple = UIColor(named: "SoftPurple")
    }
}

