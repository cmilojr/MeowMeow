//
//  Networking.swift
//  iBuy
//
//  Created by Camilo Jimenez on 4/08/21.
//

import Foundation

public class Networking {
    static let shared = Networking()
    private init(){}
    
    func get<T: Decodable>(_ url: URL, completion: @escaping (T?, Error?)-> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil,error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let res = try JSONDecoder().decode(T.self, from: data)
                    completion(res,nil)
                } catch {
                    completion(nil,error)
                }
            }
        }.resume()
    }
}


