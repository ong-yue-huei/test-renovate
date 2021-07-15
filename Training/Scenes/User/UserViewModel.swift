//
//  UserViewModel.swift
//  Training
//
//  Created by Ong Yue Huei on 15/07/2021.
//

import Combine
import ViewModelCore

final class UserViewModel: ViewModel {
    enum Action {
        case fetch
    }
    
    struct State {
        
    }
    
    var state: State { stateSubject.value }
    let stateSubject = CurrentValueSubject<State, Never>(.init())
    var statePublisher: AnyPublisher<State, Never> { stateSubject.eraseToAnyPublisher() }
    
    func send(action: Action) {
        switch action {
        case .fetch:
            print()
        }
    }
}
