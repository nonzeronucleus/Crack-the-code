//
//  Crack_The_CodeApp.swift
//  Crack The Code
//
//  Created by Ian Plumb on 27/03/2022.
//

import SwiftUI

@main
struct Crack_The_CodeApp: App {
    @State private var state = GameState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
