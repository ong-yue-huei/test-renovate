//
//  GetReposRequest.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//

import Alamofire

struct GetRepoRequest: BaseRequest {
    typealias Response = Repo
    var path: String { "/repos/\(ownerRepo)" }
    let method: HTTPMethod = .get
    let ownerRepo: String

    init(ownerRepo: String) {
        self.ownerRepo = ownerRepo
    }
}
