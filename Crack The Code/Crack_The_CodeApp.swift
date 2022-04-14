//
//  Crack_The_CodeApp.swift
//  Crack The Code
//
//  Created by Ian Plumb on 27/03/2022.
//

import SwiftUI
import ReSwift

@main
struct Crack_The_CodeApp: App {
    @ObservedObject private var store:ObservableState<AppState>  //ObservableState(store: mainStore);
    private var stateStorer:StoreStorer

    init() {
        let store = createStore()

        stateStorer =  StoreStorer(store)

        self.store = store
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

class StoreStorer : StoreSubscriber {
    @AppStorage("statsData1") var statsData = Data()
    let store:ObservableState<AppState>
    
    init(_ store:ObservableState<AppState>) {
        self.store = store

        store.dispatch(LoadStateAction(state:state))
        
        store.subscribe(self)
        
        if(state.gameState == .notStarded) {
            store.dispatch(createStartGameAction(state:store.current))
        }

    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    var state:AppState  {
        get {
            do {
                let state = try JSONDecoder().decode(AppState.self, from: statsData)
                return state
            } catch {
                log(error)
                return AppState()
            }
        }
    }
    
    func newState(state: AppState) {
        guard let stateData = try? JSONEncoder().encode(state) else {
            return
        }
        self.statsData = stateData
    }
    
    typealias StoreSubscriberStateType = AppState
}
