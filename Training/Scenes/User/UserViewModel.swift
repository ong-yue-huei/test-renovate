//
//  UserViewModel.swift
//  Training
//
//  Created by Ong Yue Huei on 15/07/2021.
//

import Combine
import ViewModelCore

final class UserViewModel: ViewModel {
    struct Dependency {
        var getUserUseCase: GetUserUseCase = GetUserDefaultUseCase()
        var getUserReposUseCase: GetUserReposUseCase = GetUserReposDefaultUseCase()
    }
    
    enum Action {
        case fetch(username: String)
    }
    
    struct State {
        var user: User?
        var sections: [Repo] = []
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
        case .fetch(let username):
            fetchEvents(username)
        }
    }
}

private extension UserViewModel {
    func fetchEvents(_ username: String) {
        dependency.getUserUseCase.perform(username: username)
            .zip(dependency.getUserReposUseCase.perform(username: username))
            .sink(receiveCompletion: { completion in
                switch completion{
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Success")
                }
            }, receiveValue: { [weak self] result in
                self?.stateSubject.value.user = result.0
                self?.stateSubject.value.sections = result.1
            })
            .store(in: &cancellables)
    }
}
