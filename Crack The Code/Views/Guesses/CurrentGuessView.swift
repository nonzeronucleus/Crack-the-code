import SwiftUI


struct CurrentGuessSquareView: View {
    let char:Character
    
    init(_ char:Character) {
        self.char = char
    }
    var body: some View {
        
        VStack(spacing: 0) {
            Text(String(char))
            Image("red-underline")
                .resizable()
                .frame(width: 32.0, height: 2.0)
        }
    }
}

struct CurrentGuessViewImpl: View {
    var guess:String
    var wordLength:Int
    
    var body: some View {
        
        HStack(spacing:4) {
            ForEach(0..<wordLength, id:\.self) { idx in
                if (idx<guess.count) {
                    CurrentGuessSquareView(guess[idx])
                }
                else {
                    CurrentGuessSquareView(" ")
                }
            }
        }
    }
}

struct CurrentGuessView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        let guess = state.current.currentGuess
        
        CurrentGuessViewImpl(guess: guess, wordLength: state.current.wordLength)
    }
}

struct CurrentGuessView_Previews: PreviewProvider {
    
    static var previews: some View {
        CurrentGuessViewImpl(guess: "WORD", wordLength: 5)
    }
}
