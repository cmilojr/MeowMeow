//
//  DependencyErrors.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

enum DependencyError: Error {
    case networkManagerNotFound
    case storageManagerNotFound
    case remoteDataManagerNotFound
    
    public var description: String {
        switch self {
        case .networkManagerNotFound:
            return "No network manager found"
        case .storageManagerNotFound:
            return "No storage manager found"
        case .remoteDataManagerNotFound:
            return "No remote data manager found"
        }
    }
}
