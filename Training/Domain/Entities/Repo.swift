//
//  Repo.swift
//  Training
//
//  Created by Ong Yue Huei on 09/07/2021.
//
import Foundation

struct Repo: Decodable {
    let id: Int32
    let name: String
    let owner: Owner
    let fullName: String
    let isPrivate: Bool
    let updatedAt: String
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forksCount: Int
    let openIssuesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case fullName = "full_name"
        case isPrivate = "private"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }

    struct Owner: Decodable {
        let id: Int32
        let name: String
        let avatarURL: URL
        
        enum CodingKeys: String, CodingKey {
            case id
            case name = "login"
            case avatarURL = "avatar_url"
        }
    }

}
