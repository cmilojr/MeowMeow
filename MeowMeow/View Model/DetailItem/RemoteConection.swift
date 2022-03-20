//
//  RemoteConection.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

protocol RemoteDataPostProtocol {
    func getAllPostsFromServer(completion: @escaping ([BreedsModel]?, Error?) -> Void)
}

struct RemoteConnection: RemoteDataPostProtocol {
    let networkManager: NetworkManagerProtocol?

    func getAllPostsFromServer(completion: @escaping ([BreedsModel]?, Error?) -> Void) {
        let urlString = ServerURL.dev.rawValue
        if let url = URL(string: urlString) {
            networkManager?.get(url) { (res: [BreedsModel]?, error: Error?) in
                if let err = error {
                    completion(nil, err)
                } else if let posts = res {
                    completion(posts, nil)
                }
            }
        } else {
            completion(nil, NetworkError.invalidUrl)
        }
    }
}
