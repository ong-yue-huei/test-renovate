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
    
    enum Action {
        case fetch(event: Event)
    }
    
    struct State {
        var repo: Repo?
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
        case .fetch(let event):
            fetchEvents(event)
        }
    }
}

private extension RepositoryViewModel {
    func fetchEvents(_ event: Event) {
        dependency.getRepoUseCase.perform(ownerRepo: event.repo.name)
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
