import SwiftUI

fileprivate struct Row: View {
    var word: String
    var rightPlace: String
    var wrongPlace: String
    var wordLength: Int
    
    var body: some View {
        HStack(spacing:4) {
            Text(word)
                .bold()
                .frame(width: Double(wordLength * 40),alignment: .leading)

            Text(rightPlace)
                .frame(width: 40,alignment: .trailing)
                .foregroundColor(.green)

            Text(wrongPlace)
                .frame(width: 40,alignment: .trailing)
                .foregroundColor(.orange)

        }
    }
}



fileprivate struct Header: View {
    var wordLength: Int
    
    var body: some View {
        Row(word: "GUESS",
            rightPlace: "✓",
            wrongPlace: "?",
            wordLength: wordLength)
    }
}

fileprivate struct GuessRow: View {
    var guess:String
    var wordToGuess:String
    var numCorrectPos:Int = 0
    var numWrongPos:Int = 0
    var wordLength: Int = 0
    
    init(wordToGuess:String, guess:String, wordLength:Int) {
        self.guess = guess
        self.wordToGuess = wordToGuess
        self.wordLength = wordLength
        let correctLetters = calcCorrectLetters(wordToGuess: wordToGuess, guess: guess)
        numCorrectPos = correctLetters.correctPos
        numWrongPos = correctLetters.wrongPos
    }
    
    var body: some View {
        Row(word: guess,
            rightPlace: String(numCorrectPos),
            wrongPlace: String(numWrongPos),
            wordLength: wordLength)
    }
}


fileprivate struct PreviousGuessesViewImpl: View {
    var prevGuesses:[String]
    var wordToGuess:String
    var wordLength:Int

    var body: some View {
        VStack {
            Header(wordLength: wordLength)
                .padding()
            ForEach(prevGuesses , id:\.self) { guess in
                GuessRow(wordToGuess:wordToGuess, guess:guess, wordLength:wordLength)
            }
        }
    }
}


struct PreviousGuessesView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

    var body: some View {
        GeometryReader { geo in
            VStack {
                PreviousGuessesViewImpl(
                    prevGuesses:state.current.previousGuesses,
                    wordToGuess: state.current.wordToGuess,
                    wordLength: state.current.wordLength
                )
            }
            .font(guessFont(size: geo.size, maxGuesses:state.current.maxGuesses))
        }
    }
}

func guessFont (size:CGSize, maxGuesses:Int) -> Font {
    return Font.custom("AnnaiMN-Regular", size: size.height/Double(2*maxGuesses))
}



struct PreviousGuessesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousGuessesViewImpl(
            prevGuesses: ["GUESS","WORDS","THING", "SSSSS"],
            wordToGuess: "SWEAR",
            wordLength: 5
        )
        .font(Font.custom("AnnaiMN-Regular", size: 18))
    }
}
