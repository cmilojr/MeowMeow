//
//  Categorys.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import Foundation
import CoreText

struct MeowMeowVM {
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
    
    func clearData() throws {
        try storage?.deleteAllData()
        UserDefaultsManager.shared.clearReadedMessages()
    }
    
    func isReaded(post: PostModel) -> Bool {
        let allReaded = UserDefaultsManager.shared.getReadedMessages()
        let res = allReaded.first { $0.userId == post.userId && $0.id == post.id }
        return res != nil
    }
    
    func saveReaded(post: PostModel) {
        UserDefaultsManager.shared.setReadedMessages(post: post)
    }
    
    func isFavorite(post: PostModel) -> Bool {
        do {
            let isFav = try storage?.checkIsFavPost(idPost: post.id, userId: post.userId)
            return isFav ?? false
        } catch {
            return false
        }
    }
}
