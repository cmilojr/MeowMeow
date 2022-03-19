//
//  Extensions.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
