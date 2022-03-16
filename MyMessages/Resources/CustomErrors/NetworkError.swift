//
//  NetworkError.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

public enum NetworkError: Error {
    case invalidUrl
    case serverError
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidUrl:
            return "The provided url is invalid"
        case .serverError:
            return "Problems connecting with the server"
        }
    }
}
