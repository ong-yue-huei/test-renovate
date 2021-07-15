//
//  RepositoryViewModel.swift
//  Training
//
//  Created by Ong Yue Huei on 15/07/2021.
//

import Combine
import ViewModelCore

final class RepositoryViewModel: ViewModel {
    enum Action {
        case temp
    }
    
    struct State {
        
    }
    
    var state: State { stateSubject.value }
    let stateSubject = CurrentValueSubject<State, Never>(.init())
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    
    init() {
           
    }
    
    func send(action: Action) {
        switch action {
        case .temp:
            print()
        }
    }
}
