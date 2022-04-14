import ReSwift

func handleResetAll() -> AppState {
    let state = AppState() // clear the state
    let startGameAction = triggerGameStart(wordLength: state.wordLength)
    
    return handleStartGame(action:startGameAction, state:AppState())
}
