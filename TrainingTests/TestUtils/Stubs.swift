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
