//
//  StorageError.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

enum StorageError: Error {
    case errorConnection
    case errorCreatingTable
    case errorDropingTable
}

extension StorageError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .errorConnection:
            return "Error communicating with database"
        case .errorCreatingTable:
            return "Error creating table in the database"
        case .errorDropingTable:
            return "Error deleting table in the database"
        }
    }
}
