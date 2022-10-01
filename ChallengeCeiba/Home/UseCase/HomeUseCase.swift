//
//  UseCaseHome.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getAllUsers(completionHandler: @escaping (Result<[UserModel], NSError>) -> Void)
    func getAllPosts(completionHandler: @escaping (Result<[PostModel], NSError>) -> Void)
}

class HomeUseCase: HomeUseCaseProtocol {

    let api: RepositoriesAPIProtocol

    init(api: RepositoriesAPIProtocol) {
        self.api = api
    }

    func getAllUsers(completionHandler: @escaping (Result<[UserModel], NSError>) -> Void) {
        api.getAllUsers { response in
            completionHandler(response)
        }
    }

    func getAllPosts(completionHandler: @escaping (Result<[PostModel], NSError>) -> Void) {
        api.getAllPosts { response in
            completionHandler(response)
        }
    }
}
