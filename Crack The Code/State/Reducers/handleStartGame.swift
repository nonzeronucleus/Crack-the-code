import Foundation
import ReSwift

func handleStartGame(action:StartGameAction, state:AppState) -> AppState {
    var state = state
    
    state.currentGuess = ""
    state.previousGuesses = []
    state.attemptedLetters = AttemptedLetters()
    
    state.wordToGuess = action.wordToGuess
    state.gameState = .inProgress
    state.currentGameMode = action.mode
    
    return state
}
