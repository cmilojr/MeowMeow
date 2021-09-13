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
}
