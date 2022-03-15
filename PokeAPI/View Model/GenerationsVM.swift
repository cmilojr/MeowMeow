//
//  Categorys.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import Foundation

struct GenerationsVM {
    func getGenerations(completion: @escaping (GenerationsModel?, Error?) -> Void) {
        let url = ""
        Networking.shared.get(URL(string: url)!) { (res: GenerationsModel?, error: Error?) in
            if let err = error {
                completion(nil, err)
            } else if let countries = res {
                completion(countries, nil)
            }
        }
    }
    
    func getPokemonAvailableInGeneration(generationUrl: String, completion: @escaping (PokemonGeneration?, Error?) -> Void) {
        Networking.shared.get(URL(string: generationUrl)!) { (res: PokemonGeneration?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
            } else if let pokemons = res {
                completion(pokemons, nil)
            }
        }
    }
    
    func getRandomPokemonAvailable(completion: @escaping (GenerationsModel?, Error?) -> Void) {
        Networking.shared.get(URL(string: "")!) { (res: GenerationsModel?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
            } else if let pokemons = res {
                completion(pokemons, nil)
            }
        }
    }
    
    func getListOfFavoritePokemons() throws -> [Description] {
        do {
            return try Storage.shared.getPokemons()
        } catch {
            throw error
        }
    }
}

