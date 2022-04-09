//
//  DebugView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 09/04/2022.
//

import SwiftUI

struct StateView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        Text(state.current.toString())
    }
}

struct ActionsView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        let actions = state.actions
        
        VStack {
            Text("Actions")
                .bold()
            ForEach(0..<actions.count , id:\.self) { index in
                let action = actions[index]
                Text("a")

                switch action {
                    
                case let loadStateAction as loadState:
                    Text("Load state "+loadStateAction.state.toString())
//                    state = handleLoadState(action: loadStateAction, state: state)
                    
                case _ as startGame:
                    Text("Start game")
                    
                case _ as resetAll:
                    Text("Reset all")

                case _ as addCharacter, _ as deleteCharacter:
                    Text("Add character")

                    // Mark: Submit guesss
                case _ as submitGuess:
                    Text("Submit guess")
                    
                default:
                    Text("Unknown answer")
                }
            }
        }
    }
}

struct DebugView: View {
    @EnvironmentObject private var state:ObservableState<AppState>
    @State var showGuess = false
    @State var showState = false

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 6.0) {
                    HStack {
                        Text("Word to guess:")
                        if(showGuess) {
                            Text(state.current.wordToGuess)
                        }
                        else {
                            Text("******")
                        }
                    }

                    Button {
                        showGuess.toggle()
                    } label: {
                        Text(showGuess ? "Hide guess":"Show guess")
                    }

                    HStack {
                        Text("State:")
                        Spacer()
                    }
                    
                    HStack {
                        if(showState) {
                            Text(state.current.toString())
                        }
                        else {
                            Text("****")
                        }
                        Spacer()
                    }

                    Button {
                        showState.toggle()
                    } label: {
                        Text(showState ? "Hide state":"Show state")
                    }
                    
                    ActionsView()

                    Button {
                        showGuess = false
                        state.dispatch(resetAll())
                        state.dispatch(startGame())
                    } label: {
                        Text("Reset all")
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
