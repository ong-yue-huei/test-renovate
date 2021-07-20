//
//  GetUserReposRequest.swift
//  Training
//
//  Created by Ong Yue Huei on 12/07/2021.
//

import Alamofire

struct GetUserReposRequest: BaseRequest {
    typealias Response = [Repo]
    var path: String { "/users/\(username)/repos" }
    let method: HTTPMethod = .get
    let username: String

    init(username: String) {
        self.username = username
    }
}
