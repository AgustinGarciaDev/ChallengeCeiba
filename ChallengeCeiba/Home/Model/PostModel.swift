//
//  PostModel.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 29/09/2022.
//

import Foundation

// MARK: - Welcome
struct PostModel: Decodable {
    let userId, id: Int
    let title, body: String
}
