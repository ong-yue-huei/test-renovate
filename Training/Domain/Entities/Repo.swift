//
//  Repo.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//
import Foundation

struct Repo: Decodable, Hashable {
    let id: Int32
    let nodeId: String
    let name: String
    let fullName: String
    let isPrivate: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
    }
    
    static func ==(lhs: Repo, rhs: Repo) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
