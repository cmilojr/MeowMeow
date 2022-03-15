//
//  NetworkResources.swift
//  PokeAPI
//
//  Created by Camilo Jiménez on 15/03/22.
//

import Foundation

public enum Resources {
    case posts
    case postComments(String)
    case postInfo(String)
    
    public var resource: String {
        switch self {
        case .posts:
            return "/posts"
        case .postComments(let id):
            return "/posts/\(id)/comments"
        case .postInfo(let id):
            return "/posts/\(id)"
        }
    }
}

public enum ServerURL: String {
    case dev = "https://jsonplaceholder.typicode.com"
}
