import SwiftUI

let maxKeysPerRow = 10.0

struct KeyboardRow: View {
    @ObservedObject private var state = ObservableState(store: mainStore);

    let spacing = 2.0
    private var letters:[Character]
    private let wideActionButtons: Bool
    
    init(_ letters:String, wideActionButtons:Bool){
        self.letters = [Character](letters)
        self.wideActionButtons = wideActionButtons
    }
    
    func getColorForChar(char: Character) -> Color {
        if let attempt = state.current.attemptedLetters[char] {
            return (attempt == .POSSIBLE)
            ? .orange
            : .gray
        }
        return Color(UIColor.systemBackground)
    }
    
    var body: some View {
        GeometryReader { geo in
            let actionButtonWidth = wideActionButtons ? geo.size.width/7 : abs((geo.size.width/maxKeysPerRow)-spacing)
            
            HStack (spacing:spacing){
                Spacer(minLength: 0)
                ForEach(letters, id:\.self) { letter in
                    let letterToShow = letter
                    
                    switch(letter) {
                    case "⌫":
                        ActionKey("⌫",
                                  onClick: {state.dispatch(deleteCharacter())},
                                  fontScale:0.6)
                            .frame(width:actionButtonWidth, height: geo.size.height, alignment:.center)
                    case "⏎":
                        ActionKey("⏎",
                                  onClick: {state.dispatch(submitGuess())},
                                  fontScale:0.5)
                            .frame(width: actionButtonWidth, height: geo.size.height, alignment:.center)
                    default:
                        LetterKey(letterToShow,
                                  color: getColorForChar(char: letterToShow),
                                  onClick: { state.dispatch(addCharacter(char: letterToShow))}
                        )
                            .frame(width: abs((geo.size.width/maxKeysPerRow)-spacing), height: geo.size.height, alignment:.center)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
}



struct Keyboard: View {
    private var keys:[String]
    private let wideActionButtons: Bool
    
    init(keys:[String], wideActionButtons: Bool = true) {
        self.keys = keys
        self.wideActionButtons = wideActionButtons
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            GeometryReader { geo in
                let keyHeight = geo.size.width/maxKeysPerRow

                    VStack {
                        Spacer()
                        GameStatusView()
                            .padding(.bottom,10)
                        
                        ErrorView()
                            .padding(.bottom,10)

                        ForEach(keys, id:\.self) { letterRow in
                            KeyboardRow(letterRow, wideActionButtons: wideActionButtons) //, state:state)
                                .frame(width: geo.size.width, height: keyHeight, alignment:
                                            .center)
                    }
                }
                .padding(.bottom, keyHeight)
            }
            .frame(alignment: .bottom)
            Spacer(minLength: 0)
        }
        .padding(6)
    }

}

struct NumberPad: View {
    private var numbers = [
        "123",
        "456",
        "789",
        "⌫0⏎"
    ]

    var body: some View {
        Keyboard(keys: numbers, wideActionButtons: false)
    }
}

struct LetterKeyboard: View {
    private var letters = [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "⌫ZXCVBNM⏎"
    ]
    
    var body: some View {
        Keyboard(keys: letters)
    }
}



struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberPad()
            LetterKeyboard()
        }
    }
}
