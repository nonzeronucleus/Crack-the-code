//
//  GameStatusView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 02/04/2022.
//

import SwiftUI

struct GameStatusView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

    var body: some View {
        state.current.gameState.gameOver
            ? AnyView(EndGameView())
            : AnyView(CurrentGuessView())
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView()
    }
}
