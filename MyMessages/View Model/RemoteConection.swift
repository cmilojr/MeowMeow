//
//  RemoteConection.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

protocol RemoteDataPostProtocol {
    func getAllPostsFromServer(completion: @escaping ([PostModel]?, Error?) -> Void)
}

protocol RemoteDataCommentsProtocol {
    func getAllCommentsOfPostFromServer(id: String, completion: @escaping ([CommentModel]?, Error?) -> Void)
}

protocol RemoteDataUserInformationProtocol {
    func getUserInformationFromServer(id: String, completion: @escaping (UserInformationModel?, Error?) -> Void)
}

struct RemoteConnection: RemoteDataPostProtocol {
    let networkManager: NetworkManagerProtocol?

    func getAllPostsFromServer(completion: @escaping ([PostModel]?, Error?) -> Void) {
        let urlString = ServerURL.dev.rawValue+Resources.posts.resource
        if let url = URL(string: urlString) {
            networkManager?.get(url) { (res: [PostModel]?, error: Error?) in
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

extension RemoteConnection: RemoteDataCommentsProtocol {
    func getAllCommentsOfPostFromServer(id: String, completion: @escaping ([CommentModel]?, Error?) -> Void) {
        let urlString = ServerURL.dev.rawValue+Resources.postComments(id).resource
        if let url = URL(string: urlString) {
            networkManager?.get(url) { (res: [CommentModel]?, error: Error?) in
                if let err = error {
                    completion(nil, err)
                } else if let comments = res {
                    completion(comments, nil)
                }
            }
        } else {
            completion(nil, NetworkError.invalidUrl)
        }
    }
}

extension RemoteConnection: RemoteDataUserInformationProtocol {
    func getUserInformationFromServer(id: String, completion: @escaping (UserInformationModel?, Error?) -> Void) {
        let urlString = ServerURL.dev.rawValue+Resources.userInformation(id).resource
        if let url = URL(string: urlString) {
            networkManager?.get(url) { (res: UserInformationModel?, error: Error?) in
                if let err = error {
                    completion(nil, err)
                } else if let userInfo = res {
                    completion(userInfo, nil)
                }
            }
        } else {
            completion(nil, NetworkError.invalidUrl)
        }
    }
}
