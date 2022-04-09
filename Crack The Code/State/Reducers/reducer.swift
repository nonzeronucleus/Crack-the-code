import ReSwift

func reducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    state.error = nil

    switch action {
        // Mark : Game management
        
    case let loadStateAction as loadState:
        state = handleLoadState(action: loadStateAction, state: state)
        
    case _ as startGame:
        state = handleStartGame(state)
        
    case _ as resetAll:
        state = handleResetAll()
        
    case _ as addCharacter, _ as deleteCharacter:
        state = handleCurrentGuess(action: action, state: state)
        
        // Mark: Submit guesss
    case _ as submitGuess:
        state = handleSubmit(state: state)
        
    default:
        break
    }
    
    return state
}
