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
        id: String = "17189128028",
        type: String = "PushEvent",
        actor: Actor = .init(
            id: 59313332,
            login: "atomjj",
            displayLogin: "github-atomjj",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/59313332?")!),
        repo: RepositorySummary = .init(
            id: 256442575,
            name: "atomjj/nanopi-openwrt",
            url:URL(string: "https://api.github.com/repos/atomjj/nanopi-openwrt")!)
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
        id: Int32 = 256442575,
        name: String = "nanopi-openwrt",
        fullName: String = "atomjj/nanopi-openwrt",
        isPrivate: Bool = false,
        owner: Owner = .init(id: 59313332, avatarURL: URL(string: "https://avatars.githubusercontent.com/u/59313332?v=4")!),
        description: String = "Openwrt for Nanopi R1S R2S R4S 香橙派 R1 Plus 固件编译 纯净版与大杂烩",
        updatedAt: Date = Date(timeIntervalSinceReferenceDate: -123456000.0),
        stargazersCount: Int = 2507,
        watchersCount: Int = 2507,
        language: String = "Shell",
        forksCount: Int = 1178,
        openIssuesCount: Int = 373
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
        id: Int64 = 59313332,
        login: String = "atomjj",
        avatarUrl: URL = URL(string: "https://avatars.githubusercontent.com/u/59313332?v=4")!,
        name: String? = "",
        followers: Int = 0,
        following: Int = 0
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
