import SwiftUI
import ReSwift

struct StateView: View {
//    @EnvironmentObject private var state:ObservableState<AppState>
    var state:AppState

    var body: some View {
        VStack {
            Text("Word Length:"+String(state.wordLength))
            Text("Max Guesses:"+String(state.maxGuesses))
            if let error = state.error {
                Text("Error:"+error)
            }
            Text("Word to Guess:"+state.wordToGuess)
            Text("Curret Guess:"+state.currentGuess)
//            Text("Previous Guesses"+state.previousGuesses)
            Text("Game Phase:"+state.gameState.rawValue)
            Text("Attempted letters:"+state.attemptedLetters.toString())
        }
    }
//        GeometryReader  { geo in
//            Text(state.toString())
//                .monospacedDigit()
////                .fixedSize(horizontal: false, vertical: true)
//                .frame(width: geo.size.width)
//        }
}

struct ActionView: View {
    var title:String
    var initState:AppState
    var endState:AppState
    var detail:String?

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()

                    GroupBox(label:Text("Initial State")) {
                       StateView(state: initState)
                    }

                    GroupBox(label:Text("Final State")) {
                       StateView(state: endState)
                    }
    

                    if let detail = detail {
                        Text(detail)
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

struct ActionsView: View {
    var actions:[ActionHistory<AppState>]
    
    init(actions:[ActionHistory<AppState>]) {
        self.actions = actions
    }

    var body: some View {
        VStack {
            Text("Actions")
                .bold()

            List {
                ForEach(0..<actions.count , id:\.self) { index in
                    let action = actions[index].action
                    let initState = actions[index].initState
                    let endState = reducer(action: action, state: initState)
                    
                    HStack {
                        switch action {

                        case _ as LoadStateAction:
                            NavigationLink(destination: ActionView(title: "Load state", initState: initState, endState: endState)) {
                                Text("Load state ")
                            }

                        case let startGame as StartGameAction:
                            NavigationLink(destination: ActionView(title: "Start game", initState: initState, endState: endState)) {
                                Text("Start game " + startGame.wordToGuess)
                            }

                        case _ as ResetAllAction:
                            NavigationLink(destination: ActionView(title: "Reset all", initState: initState, endState: endState)) {
                                Text("Reset all")
                            }

                        case let addCharacter as AddCharacterAction:
                            NavigationLink(destination: ActionView(title: "Add Character", initState: initState, endState: endState)) {
                                Text("Add character "+String(addCharacter.char))
                            }
                        case _ as DeleteCharacterAction:
                            NavigationLink(destination: ActionView(title: "Delete Character", initState: initState, endState: endState)) {
                                Text("Delete character")
                            }

                            // Mark: Submit guesss
                        case _ as SubmitGuessAction:
                            NavigationLink(destination: ActionView(title: "Submit Guess", initState: initState, endState: endState)) {
                                Text("Submit guess")
                            }

                        default:
                            Text("Unknown answer")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct DebugViewImpl: View {
    @State var showGuess = false
    @State var showState = false
    var wordToGuess:String
    var stateString:String
    var actions:[ActionHistory<AppState>]
    var resetFn :() -> Void
    
    init(wordToGuess:String, stateString:String, actions:[ActionHistory<AppState>], resetFn :@escaping () -> Void) {
        self.wordToGuess = wordToGuess
        self.stateString = stateString
        self.actions = actions
        self.resetFn = resetFn
    }

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 6.0) {
                    HStack {
                        Text("Word to guess:")
                        if(showGuess) {
                            Text(wordToGuess)
                        }
                        else {
                            Text("******")
                        }
                    }

                    Button { showGuess.toggle() } label: {
                        Text(showGuess ? "Hide guess":"Show guess")
                    }

                    HStack {
                        Text("State:")
                        Spacer()
                    }

                    HStack {
                        if(showState) {
                            Text(stateString)
                        }
                        else {
                            Text("****")
                        }
                        Spacer()
                    }

                    Button { showState.toggle() } label: {
                        Text(showState ? "Hide state":"Show state")
                    }

                    NavigationLink(destination: ActionsView(actions: actions)) {
                        Text("View Actions")
                    }

                    Button {
                        showGuess = false
                        resetFn()
//                        state.dispatch(resetAll())
//                        state.dispatch(startGame())
                    } label: {
                        Text("Reset all")
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

struct DebugView: View {
    @EnvironmentObject private var state:ObservableState<AppState>
    var body: some View {
        DebugViewImpl(
            wordToGuess: state.current.wordToGuess,
            stateString: state.current.toString(),
            actions: state.actions,
            resetFn: {state.dispatch(ResetAllAction())}
        )
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugViewImpl(
            wordToGuess: "GUESS",
            stateString: "**State**",
            actions:[], //startGame(), addCharacter(char: "A")],
            resetFn: {}
        )
//            .environmentObject( ObservableState(store: mainStore))
    }
}
