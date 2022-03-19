//
//  Constants.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit
// api_key=458a72c8-783b-453b-9c53-72bea3427bb0
public enum CellIdentifiers {
    case postDataCell
    case commentatyCell
    
    public var resource: String {
        switch self {
        case .postDataCell:
            return "PostDataCell"
        case .commentatyCell:
            return "CommentaryCell"
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
