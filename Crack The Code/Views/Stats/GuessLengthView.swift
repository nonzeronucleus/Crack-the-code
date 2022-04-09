//
//  GuessLengthView.swift
//  Wordo
//
//  Created by Ian Plumb on 12/03/2022.
//

import SwiftUI

struct GuessLengthView: View {
    var guessedLengths:[Int]
    var mostGuessedLength:Int
    
    init(maxGuesses: Int, guessedLengths:[Int]?) {
        if let guessedLengths = guessedLengths {
            self.guessedLengths = guessedLengths
            mostGuessedLength = guessedLengths.reduce(0, {(currMax, elem) in
                max(currMax,elem)
            })
        }
        else {
            self.guessedLengths = [Int](repeating: 0, count: maxGuesses)
            mostGuessedLength = 0
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text("Guesses by length")
                    .font(.headline)
                    .padding(.top, 6)
                
                ForEach(0..<guessedLengths.count , id:\.self) { index in
                    HStack {
                        let guess = (guessedLengths.count >  index) ? guessedLengths[index] : 0
                        StatRow(count: guess, max: mostGuessedLength, label:String(index+1)+":")
                    }
                }
            }
            Spacer()
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

struct GuessLengthView_Previews: PreviewProvider {
    static var previews: some View {
        GuessLengthView(maxGuesses: 3, guessedLengths: [0,3,2,12])
        GuessLengthView(maxGuesses: 3, guessedLengths: nil)
    }
}
