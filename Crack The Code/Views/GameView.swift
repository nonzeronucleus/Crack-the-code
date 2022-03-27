import SwiftUI



struct BottomView: View {
    var body: some View {
//        Keyboard()
        Text("d")
    }
}


struct GameView: View {
//    @EnvironmentObject var state: GameState
    
    var body: some View {
//        let numExtraSquared = Settings.shared.showPreviousGuessColours ? 0 : 2
//        let numSquares = state.maxLetters + numExtraSquared
        let numSquares = 5
        let padding = 25.0 - Double(numSquares)

        GeometryReader { geo in
            VStack {
                HStack (alignment: .top){
                    let size = min(geo.size.width * 0.99, geo.size.height * 0.55)

                    Spacer(minLength: 0)
                    Color.red
                        .padding(.leading,padding)
                        .padding(.trailing,padding)
                        .frame(width: size, height:size, alignment: .center)
                    Spacer()
                }
                Spacer()
//                if (state.invalidWord) {
//                    Text("Invalid Word")
//                        .font(.title)
//                }
//                BottomView()
                BottomView()
//                switch(state.status) {
//                    case .won: EndGameView(
//                        WinView(),
//                        onClick: state.startGame)
//                    case .lost:
//                        LoseView(text:"You Lost.")
//                    case .stillLost:
//                        LoseView(text:"Still Wrong.")
//                case .revealAnswer:
//                    EndGameView(
//                        RevealAnswerView(word: state.chosenWord),
//                        onClick: state.startGame
//                    )
//                    default:
//                        Keyboard(state)
//                        .disabled(state.showingAnimation)
//                }
            }
        }
        .onAppear {
//            state.showAnimation = false
        }
    }
}



struct GameView_Previews: PreviewProvider {
//    static let state = GameState()
//    static let completedState = GameState(status:.won)
//    static var stateWithLotsOfGuesses = GameState(maxGuesses: 20, maxLetters: 20)
    
    static var previews: some View {
        
        GameView()
//            .environmentObject(state)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))

//        GameView()
//            .environmentObject(state)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//
//
//        GameView()
//            .environmentObject(stateWithLotsOfGuesses)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//
//        GameView()
//            .environmentObject(stateWithLotsOfGuesses)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//
//        GameView()
//            .environmentObject(completedState)
//        GameView()
//            .environmentObject(completedState)
//            .preferredColorScheme(.dark)
    }
}
