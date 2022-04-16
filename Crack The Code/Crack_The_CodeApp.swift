import SwiftUI
import ReSwift

@main
struct Crack_The_CodeApp: App {
    @ObservedObject private var store:ObservableState<AppState>
    private var stateStorer:StateStorer

    init() {
        let store = createStore()

        stateStorer =  StateStorer(store)
        
        let loadedState = stateStorer.getSavedState()
        
        store.dispatch(LoadStateAction(state:loadedState))

        self.store = store
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}


// Stores state whenever it changes
class StateStorer : StoreSubscriber {
    let store:ObservableState<AppState>
    let url:URL

    init(_ store:ObservableState<AppState>) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        url = paths[0].appendingPathComponent("state_v1.json")
       
        self.store = store
    }
    
    func getSavedState() -> AppState {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let appData = try decoder.decode(AppState.self, from: data)
            
            // Don't subscribe to the store until we've loaded the previous state, otherwise it will get overrridden
            store.subscribe(self)
            
            return appData
        }
        catch {
            // There's no file. It's probably the first time the app's been launched
            store.subscribe(self)

            return AppState()
        }
    }

    func newState(state: AppState){
        guard let stateData = try? JSONEncoder().encode(state) else {
            return
        }
        
        do {
            try stateData.write(to: url )
        }
        catch {
            log(error)
        }
    }

    typealias StoreSubscriberStateType = AppState
}
