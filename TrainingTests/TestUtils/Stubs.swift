//
//  Stubs.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Foundation
@testable import Training

extension String {
    static func stub() -> Self {
        UUID().uuidString
    }
}

extension Int {
    static func stub() -> Self {
        Int.random(in:100..<999)
    }
}

extension Int64 {
    static func stub() -> Self {
        Int64(Int.stub())
    }
}

extension Int32 {
    static func stub() -> Self {
        Int32(Int.stub())
    }
}

extension Double {
    static func stub() -> Self {
        Double(-Int.stub())
    }
}

extension URL {
    static func stub() -> Self {
        URL(string: "https://www.google.com/search?q=\(UUID().uuidString)")!
    }
}

extension Event {
    static func stub(
        id: String = .stub(),
        type: String = .stub(),
        actor: Actor = .init(
            id: .stub(),
            login: .stub(),
            displayLogin: .stub(),
            avatarUrl: .stub()),
        repo: RepositorySummary = .init(
            id: .stub(),
            name: .stub(),
            url:.stub())
    ) -> Self {
        .init(
            id: id,
            type: type,
            actor: actor,
            repo: repo
        )
    }
}

extension Repo {
    static func stub(
        id: Int32 = .stub(),
        name: String = .stub(),
        fullName: String = .stub(),
        isPrivate: Bool = false,
        owner: Owner = .init(id: .stub(), avatarURL: .stub()),
        description: String = .stub(),
        updatedAt: Date = Date(timeIntervalSinceReferenceDate: .stub()),
        stargazersCount: Int = .stub(),
        watchersCount: Int = .stub(),
        language: String = .stub(),
        forksCount: Int = .stub(),
        openIssuesCount: Int = .stub()
    ) -> Self {
        .init(
            id: id,
            name: name,
            fullName: fullName,
            isPrivate: isPrivate,
            owner: owner,
            description: description,
            updatedAt: updatedAt,
            stargazersCount: stargazersCount,
            watchersCount: watchersCount,
            language: language,
            forksCount: forksCount,
            openIssuesCount: openIssuesCount
        )
    }
}

extension User {
    static func stub(
        id: Int64 = .stub(),
        login: String = .stub(),
        avatarUrl: URL = .stub(),
        name: String? = .stub(),
        followers: Int = .stub(),
        following: Int = .stub()
    ) -> Self {
        .init(
            id: id,
            login: login,
            avatarUrl: avatarUrl,
            name: name,
            followers: followers,
            following: following
        )
    }
}