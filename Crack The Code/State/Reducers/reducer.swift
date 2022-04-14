import ReSwift

func reducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    state.error = nil

    switch action {
        // Mark : Game management
        
    case let loadStateAction as LoadStateAction:
        state = handleLoadState(action: loadStateAction, state: state)
        
    case let startGameAction as StartGameAction:
        state = handleStartGame(action: startGameAction, state:state)
        
    case _ as ResetAllAction:
        state = handleResetAll()
        
    case _ as AddCharacterAction, _ as DeleteCharacterAction:
        state = handleCurrentGuess(action: action, state: state)
        
        // Mark: Submit guesss
    case _ as SubmitGuessAction:
        state = handleSubmit(state: state)
        
    default:
        break
    }
    
    return state
}
