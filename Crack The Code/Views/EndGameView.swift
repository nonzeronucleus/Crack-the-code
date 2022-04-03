//
//  EndGameView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 02/04/2022.
//

import SwiftUI

struct EndGameView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

    var body: some View {
        state.current.gameState == .won
            ? Text("Well done")
            : Text("Sorry. You Lost. The word was "+state.current.wordToGuess)
    }
}



struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView()
    }
}
