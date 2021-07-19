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

