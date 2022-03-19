//
//  UserDefaultManager.swift
//  MeowMeow
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
    
    func getReadedMessages() -> [BreedsModel] {
        do {
            let data = userDefault.data(forKey: UserDefaultsKeys.readedPosts.rawValue)
            if let data = data {
                return try JSONDecoder().decode([BreedsModel].self, from: data)
            }
            return []
        } catch {
            return []
        }
    }
    
    func setReadedMessages(post: BreedsModel) {
        do {
            var readedPosts = getReadedMessages()
            readedPosts.append(post)
            let data = try JSONEncoder().encode(readedPosts)
            userDefault.set(data, forKey: UserDefaultsKeys.readedPosts.rawValue)
        } catch {
            print(error)
        }
    }
    
    func clearReadedMessages() {
        userDefault.set(nil, forKey: UserDefaultsKeys.readedPosts.rawValue)
    }
}

