import SwiftUI



struct TopView: View {
    @EnvironmentObject var state: GameState

    var body: some View {
        VStack {
            PreviousGuessesView(guessTracker: state.guessTracker)
            Spacer()
//            CurrentGuessView(currentGuess: state.guessTracker.currentGuess)
        }
    }
}


struct BottomView: View {
    @EnvironmentObject var state: GameState

    var body: some View {
        LetterKeyboard(currentGuess:state.guessTracker.currentGuess)
    }
}


struct GameView: View {
    
    var body: some View {
        let numSquares = 5
        let padding = 25.0 - Double(numSquares)

        GeometryReader { geo in
            VStack {
                HStack (alignment: .top){
                    let size = min(geo.size.width * 0.99, geo.size.height * 0.55)

                    Spacer(minLength: 0)
                    TopView()
                        .padding(.leading,padding)
                        .padding(.trailing,padding)
                        .frame(width: size, height:size, alignment: .center)
                    Spacer()
                }
                Spacer()
                BottomView()
            }
        }
        .onAppear {
//            state.showAnimation = false
        }
        .font(Font.custom("AnnaiMN-Regular", size: 18))

    }
}



struct GameView_Previews: PreviewProvider {
    static let state = GameState()

    static var previews: some View {
        GameView()
            .environmentObject(state)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
