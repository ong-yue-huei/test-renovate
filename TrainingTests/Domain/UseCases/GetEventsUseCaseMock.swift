//
//  GetEventsUseCaseMock.swift
//  TrainingTests
//
//  Created by Ong Yue Huei on 19/07/2021.
//

import Combine
@testable import Training

final class GetEventsUseCaseMock: GetEventsUseCase {
    var publisher: AnyPublisher<[Event], Error> = Empty().eraseToAnyPublisher()
    
    func perform(page: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        fatalError()
    }
    
    func perform(page: Int) -> AnyPublisher<[Event], Error> {
        publisher
    }
}
