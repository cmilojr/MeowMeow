//
//  MeowMeowVC.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import Foundation
import CoreText

struct MeowMeowVM {
    var storage: LocalStorageProtocol?
    var remoteData: RemoteDataPostProtocol?
    
    func getAllPosts(completion: @escaping ([BreedsModel]?, Error?) -> Void) {
        if let remoteData = remoteData {
            remoteData.getAllPostsFromServer { posts, error in
                completion(posts,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }
}
