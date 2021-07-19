//
//  GetReposRequest.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import Alamofire

struct GetRepoRequest: BaseRequest {
    typealias Response = Repo
    let path: String
    let method: HTTPMethod = .get

    init(ownerRepo: String) {
        path = "/repos/\(ownerRepo)"
    }
}
