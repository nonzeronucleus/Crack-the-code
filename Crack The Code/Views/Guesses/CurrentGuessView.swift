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


struct CurrentGuessView: View {
    @ObservedObject var currentGuess:CurrentGuess
    
    init(currentGuess:CurrentGuess) {
        self.currentGuess = currentGuess
    }
    
    var body: some View {
        let guess = currentGuess.guess
        
        HStack(spacing:4) {
            ForEach(0..<currentGuess.length, id:\.self) { idx in
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

struct CurrentGuessView_Previews: PreviewProvider {
    static var currentCuess = CurrentGuess(length: 5, guess: "TEST")
    
    static var previews: some View {
        CurrentGuessView(currentGuess: currentCuess)
    }
}
