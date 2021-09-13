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
//        static func ItemInCategoryAvailable(_ category: String) throws -> String {
//            do {
//                let country = try Storage.shared.getLocalCountry()
//                return "https://api.mercadolibre.com/sites/\(country!.id)/search?category=\(category)"
//            } catch {
//                throw error
//            }
//        }
//        static func searchItems(item: String) throws -> String {
//            do {
//                let search = item.replacingOccurrences(of: " ", with: "%20")
//                let country = try Storage.shared.getLocalCountry()
//                return "https://api.mercadolibre.com/sites/\(country!.id)/search?q=\(search)"
//
//            } catch {
//                throw error
//            }
//        }
    }
    
    struct CellIdentifier {
        static let categoryCell = "CategoryCell"
        static let countryCell = "CountryCell"
        static let productCell = "ProductCell"
    }
    
    struct SBIdentifier {
        static let generations = "Generations"
        static let selectCountry = "SelectCountry"
    }
    
    struct LocalStorageKey {
        static let userCountry = "userCountry"
    }
    
    struct CustomColors {
        static let mintGreen = UIColor(named: "MintGreen")
        static let green = UIColor(named: "Green")
        static let orange = UIColor(named: "Orange")
        static let softPurple = UIColor(named: "SoftPurple")
        static let softGray = UIColor(named: "SoftGray")
    }
}

