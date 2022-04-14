import ReSwift

func handleResetAll() -> AppState {
    let state = AppState() // clear the state
    let startGameAction = createStartGameAction(state:state)
    
    return handleStartGame(action:startGameAction, state:AppState())
}
