import SwiftUI
import ReSwift

struct ActionHistory<T> {
    let action:Action
    let initState:T
}


public class ObservableState<T>: ObservableObject {
    // MARK: Public properties

    @Published public var current: T

    // MARK: Private properties

//    private
    private var store: Store<T>
    var actions:[ActionHistory<T>] = []
    
    // MARK: Lifecycle

    public init(store: Store<T>) {
        self.store = store
        self.current = store.state

        store.subscribe(self)
    }

    deinit {
        store.unsubscribe(self)
    }

    // MARK: Public methods

    public func dispatch(_ action: Action) {
        actions.append(ActionHistory(action: action, initState: current))
        store.dispatch(action)
    }
    
    public func createDispatch(_ action: Action) -> () -> Void {
        {
            self.store.dispatch(action)
        }
    }
    open func subscribe<S: StoreSubscriber>(_ subscriber: S)
        where S.StoreSubscriberStateType == T {
            store.subscribe(subscriber)
    }
    
    open func unsubscribe<S: StoreSubscriber>(_ subscriber: S)
        where S.StoreSubscriberStateType == T {
            store.unsubscribe(subscriber)
    }
}



extension ObservableState: StoreSubscriber {

    // MARK: - <StoreSubscriber>

    public func newState(state: T) {
        DispatchQueue.main.async {
//            log(state)
            self.current = state
        }
    }
}
