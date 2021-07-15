//
//  MainViewModel.swift
//  Training
//
//  Created by Ong Yue Huei on 15/07/2021.
//

import Combine
import ViewModelCore

final class MainViewModel: ViewModel {
    struct Dependency {
        var getEventsUseCase: GetEventsUseCase = GetEventsDefaultUseCase()
    }
    
    enum Action {
        case fetch
    }
    
    struct State {
        var sections: [Event] = []
    }

    var state: State { stateSubject.value }
    let stateSubject = CurrentValueSubject<State, Never>(.init())
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    private var cancellables: Set<AnyCancellable> = []
    private let dependency: Dependency
    
    init(dependency: Dependency = .init()) {
        self.dependency = dependency
    }
    
    func send(action: Action) {
        switch action {
        case .fetch:
            fetchEvents()
        }
    }
}

private extension MainViewModel {
    func fetchEvents() {
        dependency.getEventsUseCase.perform(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion{
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Success")
                }
            }, receiveValue: { [weak self] result in
                self?.stateSubject.value.sections = result
            })
            .store(in: &cancellables)
    }
}
