//
//  UserDefaultManager.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 17/03/22.
//

import Foundation

enum UserDefaultsKeys: String {
    case readedPosts = "readedPosts"
}

struct UserDefaultsManager {
    private let userDefault = UserDefaults.standard
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    private init() {}
    
    func getReadedMessages() -> [PostModel] {
        return userDefault.object(forKey: UserDefaultsKeys.readedPosts.rawValue) as! [PostModel]
    }
    
    func setReadedMessages(post: PostModel) {
        var readedPosts = getReadedMessages()
        readedPosts.append(post)
        userDefault.set(readedPosts, forKey: UserDefaultsKeys.readedPosts.rawValue)
    }
    
    func clearReadedMessages() {
        userDefault.set([], forKey: UserDefaultsKeys.readedPosts.rawValue)
    }
}

