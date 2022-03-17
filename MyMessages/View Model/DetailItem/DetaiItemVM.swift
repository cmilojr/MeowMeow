//
//  DetaiItemVM.swift
//  MyMessages
//
//  Created by Camilo Jimenez on 13/09/21.
//

import Foundation

struct DetailItemVM {
    var remoteCommentsData: RemoteDataCommentsProtocol?
    var remoteUserInfoData: RemoteDataUserInformationProtocol?
    var storage: LocalStorageProtocol?
    
    func getCommentsOfPost(postId: Int, completion: @escaping ([CommentModel]?, Error?) -> Void) {
        let id = String(postId)
        if let remoteCommentsData = remoteCommentsData {
            remoteCommentsData.getAllCommentsOfPostFromServer(id: id) { comments, error in
                completion(comments,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }
    
    func getUserInformation(userId: Int, completion: @escaping (UserInformationModel?, Error?) -> Void) {
        let id = String(userId)
        if let remoteUserInfoData = remoteUserInfoData {
            remoteUserInfoData.getUserInformationFromServer(id: id) { data, error in
                completion(data,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }
    
    func storePost(state: Bool, post: PostModel) throws {
        if state {
            try storage?.putPost(post)
        } else {
            try storage?.deletePost(post)
        }
    }
}
