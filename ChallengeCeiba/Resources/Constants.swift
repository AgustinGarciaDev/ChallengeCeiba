//
//  Constants.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 28/09/2022.
//

import Foundation

struct Constant {
    struct Server {
        static let baseURL = "https://jsonplaceholder.typicode.com"
    }
}

enum Header: String {
    case acceptType = "Accept"
    case contentType = "Content-Type"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
