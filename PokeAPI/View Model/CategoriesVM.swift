//
//  Categorys.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import Foundation

struct CategoriesVM {
    func getCategories(completion: @escaping ([CategoryModel]?, Error?) -> Void) {
        do {
            let url = try Constants.API.CategoriesAvailable()
            Networking.shared.getList(URL(string: url)!) { (res: [CategoryModel]?, error: Error?) in
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
    
    func getItemInCategoryAvailable(category: String, completion: @escaping (ProductsResponse?, Error?) -> Void) {
        do {
            let url = try Constants.API.ItemInCategoryAvailable(category)
            print(url)
            Networking.shared.getItems(URL(string: url)!) { (res: ProductsResponse?, error: Error?) in
                if let err = error {
                    print(err.localizedDescription)
                    print(err)
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
