//
//  Constants.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit

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
    case myMessages
    
    public var resource: String {
        switch self {
        case .myMessages:
            return "MyMessages"
        }
    }
}
