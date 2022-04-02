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
    @ObservedObject private var state = ObservableState(store: mainStore);

    var body: some View {
        let guess = state.current.currentGuess
        
        HStack(spacing:4) {
            ForEach(0..<state.current.wordLength, id:\.self) { idx in
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
    
    static var previews: some View {
        CurrentGuessView()
    }
}
