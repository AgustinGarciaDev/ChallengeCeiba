//
//  HomeUseCaseMock.swift
//  ChallengeCeibaTests
//
//  Created by Agustinch on 30/09/2022.
//

import Foundation

class RepositoriesAPIMock: BaseAPI<RepositoriesNetworking>, RepositoriesAPIProtocol {

    var usersResponse: String?
    var postsResponse: String?

    var success: Bool = false

    func getAllUsers(completionHandler: @escaping (Result<[UserModel], NSError>) -> Void) {
        
        guard let usersReponse = usersResponse, success else {
            return completionHandler(.failure(NSError()))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let info = try decoder.decode([UserModel].self, from: usersReponse.data(using: .utf8)!)
            completionHandler(.success(info))
        } catch {
            completionHandler(.failure(NSError()))
        }
    }

    func getAllPosts(completionHandler: @escaping (Result<[PostModel], NSError>) -> Void) {
       
        guard let postsReponse = postsResponse, success else {
            return completionHandler(.failure(NSError()))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let info = try decoder.decode([PostModel].self, from: postsReponse.data(using: .utf8)!)
            completionHandler(.success(info))
        } catch  {
            print(String(describing: error))
            completionHandler(.failure(NSError()))
        }

    }

}
