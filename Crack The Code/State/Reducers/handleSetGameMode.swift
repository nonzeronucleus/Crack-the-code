import ReSwift

func handleSetGameMode(state:AppState, action:SetGameModeAction) -> AppState {
    var state = state
    
    state.config.mode = action.mode
    
    return state
}

