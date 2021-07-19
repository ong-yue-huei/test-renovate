//
//  Stubs.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Foundation
@testable import Training

extension Event {
    static func stub(
        id: String = "17189128053",
        type: String = "PushEvent",
        actor: Actor = .init(
            id: 41898282,
            login: "github-actions[bot]",
            displayLogin: "github-actions",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/41898282?")!),
        repo: RepositorySummary = .init(
            id: 307825586,
            name: "carmilea/carmilea",
            url:URL(string: "https://api.github.com/repos/carmilea/carmilea")!)
    ) -> [Self] {
        [.init(
            id: id,
            type: type,
            actor: actor,
            repo: repo
        )]
    }
}

extension Repo {
    static func stub(
        id: Int32 = 307825586,
        name: String = "carmilea",
        fullName: String = "carmilea/carmilea",
        isPrivate: Bool = false,
        owner: Owner = .init(id: 38557922, avatarURL: URL(string: "https://avatars.githubusercontent.com/u/38557922?v=4")!),
        description: String = "",
        updatedAt: Date = Date(timeIntervalSinceReferenceDate: -123456000.0),
        stargazersCount: Int = 0,
        watchersCount: Int = 0,
        language: String = "",
        forksCount: Int = 0,
        openIssuesCount: Int = 0
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
