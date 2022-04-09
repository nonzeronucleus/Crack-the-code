import SwiftUI
import ReSwift

public class ObservableState<T>: ObservableObject  {

    // MARK: Public properties

    @Published public var current: T

    // MARK: Private properties

    private var store: Store<T>
    var actions:[Action] = []
    
    @AppStorage("state") var statsData = Data()

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
//        log(action)
        actions.append(action)
        store.dispatch(action)
    }
    
    public func createDispatch(_ action: Action) -> () -> Void {
        {
            self.store.dispatch(action)
        }
    }
    
    
}



extension ObservableState: StoreSubscriber {

    // MARK: - <StoreSubscriber>

    public func newState(state: T) {
        DispatchQueue.main.async {
            self.current = state
        }
    }
}
