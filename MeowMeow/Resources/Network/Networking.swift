//
//  Networking.swift
//  iBuy
//
//  Created by Camilo Jimenez on 4/08/21.
//

import Foundation

protocol NetworkManagerProtocol {
    func get<T: Decodable>(_ url: URL, completion: @escaping (T?, Error?)-> Void)
}

public class NativeNetworkManager: NetworkManagerProtocol {
    let queue = OperationQueue()
    
    func get<T: Decodable>(_ url: URL, completion: @escaping (T?, Error?)-> Void) {
        queue.qualityOfService = .utility
        let urlSession = URLSession.init(
            configuration: .default,
            delegate: nil,
            delegateQueue: queue
        )
        
        urlSession.dataTask(with: url) { data, response, error in
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


