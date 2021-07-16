//
//  RepositoryViewModel.swift
//  Training
//
//  Created by Ong Yue Huei on 15/07/2021.
//

import Combine
import ViewModelCore

final class RepositoryViewModel: ViewModel {
    struct Dependency {
        var getRepoUseCase: GetRepoUseCase = GetRepoDefaultUseCase()
    }
    
    struct Argument {
        let event: Event
    }
    
    enum Action {
        case fetch
    }
    
    struct State {
        var repo: Repo?
    }
    
    let argument: Argument
    var state: State { stateSubject.value }
    let stateSubject = CurrentValueSubject<State, Never>(.init())
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    private var cancellables: Set<AnyCancellable> = []
    private let dependency: Dependency
    
    init(argument: Argument, dependency: Dependency = .init()) {
        self.argument = argument
        self.dependency = dependency
    }
    
    func send(action: Action) {
        switch action {
        case .fetch:
            fetchEvents()
        }
    }
}

private extension RepositoryViewModel {
    func fetchEvents() {
        dependency.getRepoUseCase.perform(ownerRepo: argument.event.repo.name)
            .sink(receiveCompletion: { completion in
                switch completion{
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Success")
                }
            }, receiveValue: { [weak self] result in
                self?.stateSubject.value.repo = result
            })
            .store(in: &cancellables)
    }
}
