//
//  GetUserUseCaseMock.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import XCTest

import Combine
@testable import Training

final class GetUserUseCaseMock: GetUserUseCase {
    enum CallArg: Equatable {
        case perform(username: String)
    }
    
    var publisher: AnyPublisher<User, Error> = Empty().eraseToAnyPublisher()
    private(set) var callArgs: [CallArg] = []
    
    func perform(username: String, completion: @escaping (Result<User, Error>) -> Void) {
        fatalError()
    }
    
    func perform(username: String) -> AnyPublisher<User, Error> {
        callArgs.append(.perform(username: username))
        return publisher
    }
}
