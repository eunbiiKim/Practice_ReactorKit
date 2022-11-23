//
//  CounterViewReactor.swift
//  Practice_ReactorKit
//
//  Created by eunbiiKim on 2022/11/23.
//

import ReactorKit
import RxSwift

final class CounterViewReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .increase:
                return Observable.concat([
                    Observable.just(Mutation.setLoading(true)),
                    Observable.just(Mutation.increaseValue)
                        .delay(.seconds(1), scheduler: MainScheduler.instance),
                    Observable.just(Mutation.setLoading(false))
                ])
                
            case .decrease:
                return Observable.concat([
                    Observable.just(Mutation.setLoading(true)),
                    Observable.just(Mutation.decreaseValue)
                        .delay(.seconds(1), scheduler: MainScheduler.instance),
                    Observable.just(Mutation.setLoading(false))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            case .increaseValue:
                newState.value += 1
            case .decreaseValue:
                newState.value -= 1
            case let .setLoading(isLoading):
                newState.isLoading = isLoading
        }
        return newState
    }
}
