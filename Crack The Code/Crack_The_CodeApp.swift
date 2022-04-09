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
    @ObservedObject private var state = ObservableState(store: mainStore);
    private var stateStorer:StoreStorer

    init() {
        stateStorer =  StoreStorer()
        
        let loadedState = stateStorer.state

        mainStore.subscribe(stateStorer)

        state.dispatch(loadState(state:loadedState))
        
        if(loadedState.gameState == .notStarded) {
            state.dispatch(startGame())
        }
        
//        state.dispatch(startGame())
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}

class StoreStorer : StoreSubscriber {
    @AppStorage("statsData1") var statsData = Data()
    
    var state:AppState  {
        get {
            do {
//                let state = AppState()
                let state = try JSONDecoder().decode(AppState.self, from: statsData)
//
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
//        log(state)
//        log(state.attemptedLetters.toString())
    }
    
    typealias StoreSubscriberStateType = AppState
}
