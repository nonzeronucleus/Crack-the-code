//
//  GameStatusView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 02/04/2022.
//

import SwiftUI

struct GameStatusView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        state.current.gameState.gameOver
            ? AnyView(EndGameView())
            : AnyView(LetterKeyboard())
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView()
    }
}
