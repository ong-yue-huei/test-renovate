//
//  GetUserReposUseCaseMock.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import XCTest

import Combine
@testable import Training

final class GetUserReposUseCaseMock: GetUserReposUseCase {
    enum CallArg: Equatable {
        case perform(username: String)
    }
    
    var publisher: AnyPublisher<[Repo], Error> = Empty().eraseToAnyPublisher()
    private(set) var callArgs: [CallArg] = []
    
    func perform(username: String, completion: @escaping (Result<[Repo], Error>) -> Void) {
        fatalError()
    }
    
    func perform(username: String) -> AnyPublisher<[Repo], Error> {
        callArgs.append(.perform(username: username))
        return publisher
    }
}
