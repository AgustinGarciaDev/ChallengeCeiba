//
//  HomeTests.swift
//  ChallengeCeibaTests
//
//  Created by Agustinch on 30/09/2022.
//

import XCTest
@testable import ChallengeCeiba

class HomeUseCaseTest: XCTestCase {

    var usersJsonSuccess: String {
        """
        [
          {
                   "id": 1,
                   "name": "Leanne Graham",
                   "username": "Bret",
                   "email": "Sincere@april.biz",
                   "address": {
                       "street": "Kulas Light",
                       "suite": "Apt. 556",
                       "city": "Gwenborough",
                       "zipcode": "92998-3874",
                       "geo": {
                           "lat": "-37.3159",
                           "lng": "81.1496"
                       }
                   },
                   "phone": "1-770-736-8031 x56442",
                   "website": "hildegard.org",
                   "company": {
                       "name": "Romaguera-Crona",
                       "catchPhrase": "Multi-layered client-server neural-net",
                       "bs": "harness real-time e-markets"
                   }
          }
        ]
        """
    }

    var postsJsonSuccess: String {
        """
        [
            {
                   "userId": 1,
                   "id": 2,
                   "title": "qui est esse",
                   "body": "est rerum tempore vitae"
            }
        ]
        """
    }

    func test_getAllUsers_UseCase_whenSucessfully() {
        //Setup
        let repository = RepositoriesAPIMock()
        repository.success = true
        repository.usersResponse = usersJsonSuccess
        let sut = HomeUseCase(api: repository)

        //Test
        sut.getAllUsers { response in
            switch response {
            case .success(_):
                //Verify
                XCTAssertTrue(true)
            case .failure(_):
                //Verify
                XCTFail("The response must be a Success")
            }
        }
    }

    func test_getAllUsers_UseCase_whenFailure() {
        //Setup
        let repository = RepositoriesAPIMock()
        repository.success = false

        let sut = HomeUseCase(api: repository)

        //Test
        sut.getAllUsers { response in
            switch response {
            case .success(_):
                //Verify
                XCTFail("The response must be a Success")
            case .failure(_):
                //Verify
                XCTAssertTrue(true)
            }
        }
    }

    func test_getAllPosts_UseCase_whenSucessfully() {
        //Setup
        let repository = RepositoriesAPIMock()
        repository.success = true
        repository.postsResponse = postsJsonSuccess
        
        let sut = HomeUseCase(api: repository)

        //Test
        sut.getAllPosts { response in
            switch response {
            case .success(_):
                //Verify
                XCTAssertTrue(true)
            case .failure(_):
                //Verify
                XCTFail("The response must be a Success")
            }
        }
    }

    func test_getPosts_UseCase_whenFailure() {
        //Setup
        let repository = RepositoriesAPIMock()
        repository.success = false

        let sut = HomeUseCase(api: repository)

        //Test
        sut.getAllPosts { response in
            switch response {
            case .success(_):
                //Verify
                XCTFail("The response must be a Success")
            case .failure(_):
                //Verify
                XCTAssertTrue(true)
            }
        }
    }

}
