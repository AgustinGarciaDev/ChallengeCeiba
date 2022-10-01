//
//  UserModel.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation

// MARK: - User

struct UserModel: Decodable {
    let id: Int
    let name, username, email: String
    let phone: String
}
