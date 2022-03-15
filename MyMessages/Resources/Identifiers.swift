//
//  Constants.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit

public enum CellIdentifiers {
    case categoryCell
    
    public var resource: String {
        switch self {
        case .categoryCell:
            return "CategoryCell"
        }
    }
}

public enum SBIdentifier {
    case generations
    
    public var resource: String {
        switch self {
        case .generations:
            return "Generations"
        }
    }
}
