//
//  RepositoryNetwork.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation

enum RepositoriesNetworking {
    case getPostUser(id: String)
    case getAllUsers
    case getPost
}

extension RepositoriesNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return Constant.Server.baseURL
        }
    }

    var path: String {
        switch self {
        case .getPostUser(let id):
            return "/posts?userId=\(id)"
        case .getAllUsers:
            return "/users"
        case .getPost:
            return "/posts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPostUser:
            return .get
        case .getAllUsers:
            return .get
        case .getPost:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAllUsers:
            return .requestPlain
        case .getPostUser:
            return .requestPlain
        case .getPost:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return [:]
        }
    }

}
