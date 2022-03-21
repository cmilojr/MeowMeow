//
//  Constants.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit

public enum CellIdentifiers {
    case catDataCell
    
    public var resource: String {
        switch self {
        case .catDataCell:
            return "CatDataCell"
        }
    }
}

public enum SBIdentifier {
    case homeVC
    
    public var resource: String {
        switch self {
        case .homeVC:
            return "Home"
        }
    }
}
