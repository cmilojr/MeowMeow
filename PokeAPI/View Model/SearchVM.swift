//
//  Search.swift
//  iBuy
//
//  Created by Camilo Jimenez on 10/08/21.
//

import Foundation

struct SearchVM {
    func getRelatedItems(itemName: String, completion: @escaping (ProductsResponse?, Error?) -> Void) {
        do {
            let url = try Constants.API.searchItems(item: itemName)
            Networking.shared.getItems(URL(string: url)!) { (res: ProductsResponse?, error: Error?) in
                if let err = error {
                    completion(nil, err)
                } else if let countries = res {
                    completion(countries, nil)
                }
            }
        } catch {
            completion(nil, error)
        }
    }
}
