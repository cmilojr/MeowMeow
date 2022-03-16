//
//  DetaiItemVM.swift
//  MyMessages
//
//  Created by Camilo Jimenez on 13/09/21.
//

import Foundation


struct DetailItemVM {
    var remoteData: RemoteDataCommentsProtocol?
    
    func getCommentsOfPost(postId: String, completion: @escaping ([CommentModel]?, Error?) -> Void) {
        if let remoteData = remoteData {
            remoteData.getAllCommentsOfPostFromServer(id: postId) { comments, error in
                completion(comments,error)
            }
        } else {
            completion(nil, DependencyError.remoteDataManagerNotFound)
        }
    }
}
