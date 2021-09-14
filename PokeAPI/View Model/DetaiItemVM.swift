//
//  DetaiItemVM.swift
//  PokeAPI
//
//  Created by Camilo Jimenez on 13/09/21.
//

import Foundation


struct DetailItemVM {
    func getPokemonDetail(name: String, completion: @escaping (PokemonDetailModel?, Error?) -> Void) {
        Networking.shared.get(URL(string: Constants.API.pokemonDetail+name)!) { (res: PokemonDetailModel?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
            } else if let pokemon = res {
                completion(pokemon, nil)
            }
        }
    }
    
    func savePokemonDetail(_ pokemonDetail: Description) throws {
        do {
            try Storage.shared.putPokemon(pokemonDescription: pokemonDetail)
        } catch {
            throw error
        }
    }
    
    func getListOfFavoritePokemons() throws -> [Description] {
        do {
            return try Storage.shared.getPokemons()
        } catch {
            throw error
        }
    }
    
    func checkPokemon(_ info: Description) throws -> Bool {
        do {
            return try Storage.shared.checkPokemon(name: info.name)
        } catch {
            throw error
        }
    }
    
    func deletePokemon(_ info: Description) throws {
        do {
            try Storage.shared.deletePokemon(name: info.name)
        } catch {
            throw error
        }
    }
}
