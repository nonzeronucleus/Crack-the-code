import SwiftUI



struct TopView: View {

    var body: some View {
        VStack {
            PreviousGuessesView()
            Spacer()
        }
    }
}


struct BottomView: View {
    var body: some View {
        LetterKeyboard()
    }
}


struct GameView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

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
            .font(Font.custom("AnnaiMN-Regular", size:18))
        }
        .onAppear {
//            state.showAnimation = false
        }
    }
}

//36



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
