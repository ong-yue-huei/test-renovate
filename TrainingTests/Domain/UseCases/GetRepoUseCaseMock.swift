//
//  GetRepoUseCaseMock.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import XCTest

import Combine
@testable import Training

final class GetRepoUseCaseMock: GetRepoUseCase {
    enum CallArg: Equatable {
        case perform(ownerRepo: String)
    }
    
    var publisher: AnyPublisher<Repo, Error> = Empty().eraseToAnyPublisher()
    private(set) var callArgs: [CallArg] = []
    
    func perform(ownerRepo: String, completion: @escaping (Result<Repo, Error>) -> Void) {
        fatalError()
    }
    
    func perform(ownerRepo: String) -> AnyPublisher<Repo, Error> {
        callArgs.append(.perform(ownerRepo: ownerRepo))
        return publisher
    }
}
