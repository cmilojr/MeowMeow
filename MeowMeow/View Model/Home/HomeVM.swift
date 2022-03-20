//
//  HomeVM.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import Foundation

struct HomeVM {
    var remoteData: RemoteDataPostProtocol?
    var storage: LocalStorageProtocol?
    
    func getAllPosts(completion: @escaping ([BreedsModel]?, Error?) -> Void) {
        if let remoteData = remoteData {
            remoteData.getAllPostsFromServer { posts, error in
                completion(posts,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }
    
    func storeCat(cat: BreedsModel, status: Bool) throws {
        do {
            try storage?.putPost(didLike: status, catData: cat, date: Date())
        } catch {
            throw DependencyError.storageManagerNotFound
        }
    }
}
