import ReSwift

func deleteChar(_ text:String) -> String {
    if (text.count == 0) {
        // String is empty
        return text
    }
   return String(text.prefix(text.count-1))
}

func handleCurrentGuess(action: Action, state: AppState) -> AppState {
    var state = state
    
    if (state.gameState.gameOver) {
        // Don't handle keyboard input if game is over
        return state
    }
    
    switch action {
        // MARK: current guess
    case let addChar as AddCharacterAction:
        if (state.currentGuess.count<state.wordLength) {
            state.currentGuess.append(addChar.char)
        }
    case _ as DeleteCharacterAction:
        state.currentGuess = deleteChar(state.currentGuess)
    default:
        break
    }
    
    return state
}
