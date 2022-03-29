//
//  PreviousGuessesView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 28/03/2022.
//

import SwiftUI

struct PreviousGuessSquareView: View {
    let char:Character
    
    init(_ char:Character) {
        self.char = char
    }
    var body: some View {
        
        VStack(spacing: 0) {
            Text(String(char))
//            Image("red-underline")
//                .resizable()
//                .frame(width: 32.0, height: 2.0)
        }
    }
}



struct PreviousGuessRowView: View {
    var guess:String
    
    init(guess:String) {
        self.guess = guess
    }
    
    var body: some View {
        HStack(spacing:4) {
            ForEach(0..<guess.count, id:\.self) { idx in
                PreviousGuessSquareView(guess[idx])
            }
        }
    }
}

struct PreviousGuessesView: View {
    @ObservedObject var guessTracker:GuessTracker
    
    var body: some View {
        VStack {
            let prevGuesses = guessTracker.prevGuesses
            ForEach(prevGuesses , id:\.self) { guess in
                PreviousGuessRowView(guess:guess.guess)
            }
        }
    }
}

struct PreviousGuessesView_Previews: PreviewProvider {
    static let guessTracker = GuessTracker()
    
    static var previews: some View {
        PreviousGuessesView(guessTracker: guessTracker)
    }
}
