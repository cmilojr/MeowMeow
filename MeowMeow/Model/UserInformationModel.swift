//
//  UserInformationModel.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import Foundation

struct UserInformationModel: Codable {
    var id: Int
    var name: String?
    var email: String?
    var phone: String?
    var website: String?
}
