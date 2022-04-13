import SwiftUI


fileprivate struct ColoredString {
    var text: String
    var colors : [Color]?
    
    init(_ text:String) {
        self.text = text
        self.colors = nil
    }
    
    init(_ text:String, colors:[Color]?) {
        self.text = text
        self.colors = colors
    }
    
    subscript(index: Int) -> (char:Character, color:Color) {
        get {
            return (char:text[index], color:colors == nil ? .primary: colors![index])
        }
    }
    
    var count:Int {
        get {
            return text.count
        }
    }
}


fileprivate struct ColoredText: View {
    var text:ColoredString
    
    init(_ text:ColoredString) {
        self.text = text
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<text.count , id:\.self) { index in
                let elem = text[index]
                
                Text(String(elem.char))
                    .foregroundColor(elem.color)
                    .bold()
            }
        }
    }
}


fileprivate struct Row: View {
    var word: ColoredString
    var rightPlace: String
    var wrongPlace: String
    var wordLength: Int
    
    var body: some View {
        HStack(spacing:4) {
            ColoredText(word)
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
    var maxGuesses: Int
    var currentGuess: Int
    
    var body: some View {
        Row(word:ColoredString( "GUESS "+String(currentGuess)+" of "+String(maxGuesses)),
            rightPlace: "✓",
            wrongPlace: "?",
            wordLength: wordLength)
    }
}

fileprivate struct GuessRow: View {
    var guess:ColoredString
    var wordToGuess:String
    var numCorrectPos:Int = 0
    var numWrongPos:Int = 0
    var wordLength: Int = 0
    
    init(wordToGuess:String, guess:String, wordLength:Int, gameInProgress:Bool) {
        var colors:[Color]? = nil
        self.wordToGuess = wordToGuess
        self.wordLength = wordLength
        let overlap = guess.overlap(with: wordToGuess)
        let correctLetters = (correctPos:overlap.exact.count, wrongPos:overlap.inWord.count)
        if (!gameInProgress) {
            colors = [Color](repeating:.wrong, count: wordLength)
            for exact in overlap.exact {
                colors![exact] = .correct
            }
            for inWord in overlap.inWord {
                colors![inWord] = .inWord
            }

        }
        self.guess = ColoredString(guess, colors:colors)
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
    var maxGuesses: Int
    var currentGuesses: Int
    var gameInProgress:Bool

    var body: some View {
        VStack {
            Header(wordLength: wordLength, maxGuesses: maxGuesses, currentGuess:currentGuesses)
                .padding()
            ForEach(prevGuesses , id:\.self) { guess in
                GuessRow(wordToGuess:wordToGuess, guess:guess, wordLength:wordLength, gameInProgress:gameInProgress)
            }
        }
    }
}


struct PreviousGuessesView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        GeometryReader { geo in
            VStack {
                PreviousGuessesViewImpl(
                    prevGuesses:state.current.previousGuesses,
                    wordToGuess: state.current.wordToGuess,
                    wordLength: state.current.wordLength,
                    maxGuesses: state.current.maxGuesses,
                    currentGuesses: state.current.previousGuesses.count +
                        (state.current.gameState == .inProgress ? 1 : 0),
                    gameInProgress: state.current.gameState == .inProgress
                    
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
            wordLength: 5,
            maxGuesses: 12,
            currentGuesses: 4,
            gameInProgress: true
        )
        .font(Font.custom("AnnaiMN-Regular", size: 18))
        PreviousGuessesViewImpl(
            prevGuesses: ["GUESS","WORDS","THING", "SSSSS"],
            wordToGuess: "SWEAR",
            wordLength: 5,
            maxGuesses: 12,
            currentGuesses: 4,
            gameInProgress: false
        )
        .font(Font.custom("AnnaiMN-Regular", size: 18))
    }
}
