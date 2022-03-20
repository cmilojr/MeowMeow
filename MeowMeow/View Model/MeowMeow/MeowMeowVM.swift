//
//  MeowMeowVC.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import Foundation
import CoreText

struct MeowMeowVM {
    var storage: LocalStorageProtocol?
    
    func getAllStoredCats() -> [DataModel] {
        do {
            return try storage?.getCats() ?? []
        } catch {
            return []
        }
    }
}
