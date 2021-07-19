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
    
    struct Argument {
        let username: String
    }
    
    struct Section: Equatable {
         let type: SectionType
         let cells: [Repo]
     }

     enum SectionType {
         case events
     }

    enum Action {
        case fetch
    }
    
    struct State {
        var user: User?
        var sections: [Section] = []
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

private extension UserViewModel {
    func fetchEvents() {
        dependency.getUserUseCase.perform(username: argument.username)
            .zip(dependency.getUserReposUseCase.perform(username: argument.username))
            .sink(receiveCompletion: { completion in
                switch completion{
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Success")
                }
            }, receiveValue: { [weak self] result in
                self?.stateSubject.value.user = result.0
                self?.stateSubject.value.sections = [Section(type: .events, cells: result.1)]
            })
            .store(in: &cancellables)
    }
}
