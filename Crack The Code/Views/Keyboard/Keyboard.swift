import SwiftUI
import ReSwift


let maxKeysPerRow = 10.0

fileprivate struct KeyboardRow: View {
    private let spacing = 2.0
    private var letters:[Character]
    private let wideActionButtons: Bool
    private let attemptedLetters:AttemptedLetters
    private let controller:KeyboardController

    init(_ letters:String,
         attemptedLetters:AttemptedLetters,
         controller:KeyboardController,
         wideActionButtons:Bool
    ){
        self.letters = [Character](letters)
        self.attemptedLetters = attemptedLetters
        self.wideActionButtons = wideActionButtons
        self.controller = controller
    }
    
    func getColorForChar(char: Character) -> Color {
        if let attempt = attemptedLetters.getStatus(char) {
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
                                  onClick: {controller.deleteChar() },        //{state.dispatch(deleteCharacter())},
                                  fontScale:0.6)
                            .frame(width:actionButtonWidth, height: geo.size.height, alignment:.center)
                    case "⏎":
                        ActionKey("⏎",
                                  onClick: {controller.submit()},
                                  fontScale:0.5)
                            .frame(width: actionButtonWidth, height: geo.size.height, alignment:.center)
                    default:
                        LetterKey(letterToShow,
                                  color: getColorForChar(char: letterToShow),
                                  onClick: {controller.addChar(letterToShow)}
                        )
                            .frame(width: abs((geo.size.width/maxKeysPerRow)-spacing), height: geo.size.height, alignment:.center)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
}




fileprivate struct Keyboard: View {
    private let controller:KeyboardController
    private let attemptedLetters:AttemptedLetters

    private var keys:[String]
    private let wideActionButtons: Bool
    
    init(keys:[String], attemptedLetters:AttemptedLetters, controller:KeyboardController, wideActionButtons: Bool = true) {
        self.keys = keys
        self.wideActionButtons = wideActionButtons
        self.controller = controller
        self.attemptedLetters = attemptedLetters
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            GeometryReader { geo in
                let keyHeight = geo.size.width/maxKeysPerRow
                    VStack {
                        Spacer()
                        CurrentGuessView()
                            .padding(.bottom,10)

                        ErrorView()
                            .padding(.bottom,10)

                        ForEach(keys, id:\.self) { letterRow in
                            KeyboardRow(letterRow,
                                        attemptedLetters: attemptedLetters,
                                        controller: controller,
                                        wideActionButtons: wideActionButtons
                            )
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


fileprivate struct NumberPadImpl: View {
    private var numbers = [
        "123",
        "456",
        "789",
        "⌫0⏎"
    ]
    
    
    private let controller:KeyboardController
    private let attemptedLetters:AttemptedLetters

    init(attemptedLetters:AttemptedLetters, controller:KeyboardController) {
        self.controller = controller
        self.attemptedLetters = attemptedLetters
    }
    
    var body: some View {
        Keyboard(keys: numbers, attemptedLetters: attemptedLetters, controller: controller, wideActionButtons: false)
    }
}

fileprivate struct LetterKeyboardImpl: View {
    private var letters = [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "⌫ZXCVBNM⏎"
    ]
    
    private let controller:KeyboardController
    private let attemptedLetters:AttemptedLetters

    init(attemptedLetters:AttemptedLetters, controller:KeyboardController) {
        self.controller = controller
        self.attemptedLetters = attemptedLetters
    }
    
    var body: some View {
        Keyboard(keys: letters, attemptedLetters: attemptedLetters, controller: controller)
    }
}

protocol KeyboardController {
    
    func addChar(_ char:Character)
    
    func deleteChar()
    
    func submit()
}

fileprivate class GameKeyboardController: KeyboardController {
    private let state:ObservableState<AppState>
    
    init(state:ObservableState<AppState>) {
        self.state = state
    }

    func addChar(_ char:Character) {
        state.dispatch(addCharacter(char: char))
    }
    
    func deleteChar() {
        state.dispatch(deleteCharacter())
    }
    
    func submit() {
        state.dispatch(submitGuess())
    }
}

fileprivate class TestKeyboardController: KeyboardController {
    func addChar(_ char:Character) {
    }
    
    func deleteChar() {
    }
    
    func submit() {
    }
}


struct LetterKeyboard: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        LetterKeyboardImpl(attemptedLetters: state.current.attemptedLetters, controller: GameKeyboardController(state: state))
    }
}


struct Keyboard_Previews: PreviewProvider {
    static let attemptedLetters = AttemptedLetters(attempts: ["A":.POSSIBLE, "B":.NOT_IN_WORD] )
    static let attemptedNumbers = AttemptedLetters(attempts: ["1":.POSSIBLE, "2":.NOT_IN_WORD] )

    static var previews: some View {
        NumberPadImpl(attemptedLetters: attemptedNumbers, controller: TestKeyboardController())
            .environmentObject( ObservableState(store: mainStore))

        LetterKeyboardImpl(attemptedLetters: attemptedLetters, controller: TestKeyboardController())
            .environmentObject( ObservableState(store: mainStore))
    }
}
