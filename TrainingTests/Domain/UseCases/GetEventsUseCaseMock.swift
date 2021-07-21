//
//  GetEventsUseCaseMock.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training

final class GetEventsUseCaseMock: GetEventsUseCase {
    enum CallArg: Equatable {
        case perform(page: Int)
    }
    
    var publisher: AnyPublisher<[Event], Error> = Empty().eraseToAnyPublisher()
    private(set) var callArgs: [CallArg] = []
    
    func perform(page: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fatalError()
    }
    
    func perform(page: Int) -> AnyPublisher<[Event], Error> {
        callArgs.append(.perform(page: page))
        return publisher
    }
}
