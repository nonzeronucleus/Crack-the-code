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

    init() {
//        let dispatch = #selector(state.dispatch as (_ action: Action) )
        state.dispatch(startGame())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
