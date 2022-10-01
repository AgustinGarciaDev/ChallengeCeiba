//
//  RepositoryAPI.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation

protocol RepositoriesAPIProtocol {
    func getAllUsers(completionHandler: @escaping (Result<[UserModel], NSError>) -> Void)
    func getAllPosts(completionHandler: @escaping (Result<[PostModel], NSError>) -> Void)
}

class RepositoriesAPI: BaseAPI<RepositoriesNetworking>, RepositoriesAPIProtocol {

    func getAllUsers(completionHandler: @escaping (Result<[UserModel], NSError>) -> Void) {
        self.fetchData(target: .getAllUsers, responseClass: [UserModel].self) { (result) in
            completionHandler(result)
        }
    }

    func getAllPosts(completionHandler: @escaping (Result<[PostModel], NSError>) -> Void) {
        self.fetchData(target: .getPost, responseClass: [PostModel].self) { (result) in
            completionHandler(result)
        }
    }

}
