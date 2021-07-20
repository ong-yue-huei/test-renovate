//
//  GetUserRequest.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import Alamofire

struct GetUserRequest: BaseRequest {
    typealias Response = User
    var path: String { "/users/\(username)" }
    let method: HTTPMethod = .get
    let username: String

    init(username: String) {
        self.username = username
    }
}
