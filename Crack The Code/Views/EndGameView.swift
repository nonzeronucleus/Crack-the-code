//
//  EndGameView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 02/04/2022.
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        VStack {
            state.current.gameState == .won
                ? Text("Well done")
                : Text("Sorry. You Lost. The word was "+state.current.wordToGuess)
            
            NewGameButton()
            
            Spacer()
        }
    }
}



struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView()
    }
}
