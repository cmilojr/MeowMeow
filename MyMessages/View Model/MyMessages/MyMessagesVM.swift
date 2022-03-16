//
//  Categorys.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import Foundation

struct MyMessagesVM {
    var storage: LocalStorageProtocol?
    var remoteData: RemoteDataPostProtocol?
    
    func getAllPosts(completion: @escaping ([PostModel]?, Error?) -> Void) {
        if let remoteData = remoteData {
            remoteData.getAllPostsFromServer { posts, error in
                completion(posts,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }

    func getListOfFavoritePost() throws -> [PostModel] {
        if let storage = storage {
            return try storage.getFavoritePosts()
        } else {
            throw DependencyError.storageManagerNotFound
        }
    }
}
