import SwiftUI



fileprivate struct Header: View {
    var body: some View {
        HStack(spacing:4) {
            Text("GUESS")
                .bold()
                .frame(width: 100,alignment: .leading)

            Text("✓")
                .frame(width: 40,alignment: .trailing)
                .foregroundColor(.green)

            Text("?")
                .frame(width: 40,alignment: .trailing)
                .foregroundColor(.orange)

        }
    }
}

fileprivate struct Row: View {
    var guess:String
    var wordToGuess:String
    var numCorrectPos:Int = 0
    var numWrongPos:Int = 0
    
    init(wordToGuess:String, guess:String) {
        self.guess = guess
        self.wordToGuess = wordToGuess
        let correctLetters = calcCorrectLetters(wordToGuess: wordToGuess, guess: guess)
        numCorrectPos = correctLetters.correctPos
        numWrongPos = correctLetters.wrongPos
    }
    
    var body: some View {
        HStack(spacing:4) {
            Text(guess)
                .kerning(6)
                .frame(width: Double(guess.count * 20),alignment: .leading)

            Text(String(numCorrectPos))
                .foregroundColor(.green)
                .frame(width: 40,alignment: .trailing)

            Text(String(numWrongPos))
                .frame(width: 40,alignment: .trailing)
                .foregroundColor(.orange)


        }
    }
}


fileprivate struct Impl: View {
    var prevGuesses:[String]
    var wordToGuess:String

    var body: some View {
        VStack {
            Header()
                .padding()
            ForEach(prevGuesses , id:\.self) { guess in
                Row(wordToGuess:wordToGuess, guess:guess)
            }
        }
        .font(gameFont)
    }
}


struct PreviousGuessesView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

    var body: some View {
        VStack {
            Impl(
                prevGuesses:state.current.previousGuesses,
                wordToGuess: state.current.wordToGuess)
        }
    }
}

struct PreviousGuessesView_Previews: PreviewProvider {
    static var previews: some View {
        Impl(
            prevGuesses: ["GUESS","WORDS","THING", "SSSSS"],
            wordToGuess: "SWEAR"
        )
    }
}
