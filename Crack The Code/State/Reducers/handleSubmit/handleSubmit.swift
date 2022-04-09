import Foundation
import ReSwift

fileprivate func checkForErrors(state: AppState) -> String? {
    let currentGuess = state.currentGuess
    let wordLength = state.wordLength
    let previousGuesses = state.previousGuesses
    
    if (currentGuess.count<wordLength) {
        return "Word too short"
    }
    
    if (previousGuesses.contains(where: {$0 == currentGuess})) {
        return "You've already tried that one"
    }
    
    if(!WordList.long.contains(where: {$0 == currentGuess})) {
        return "Sorry. I don't know that word"
    }
    
    return nil
}

fileprivate func handleWin(state: AppState) -> AppState {
    var state = state
    state.gameState = .won
    

    var stats = state.stats
    stats.wins += 1
    stats.streak += 1
    
    var guessedLengths = getGuessLengths(guessedLengths: stats.guessedLengths, maxGuesses: state.maxGuesses)
    
    // You can't get a guess in zero letters, so shift the array down by 1 (e.g. [0] is the number of times it's been guessed in 1 go)
    guessedLengths[state.previousGuesses.count-1] += 1
    
    stats.guessedLengths = guessedLengths
    state.stats = stats
    
    return state
}


fileprivate func handleLoss(state: AppState) -> AppState {
    var state = state
    state.gameState = .lost
    var stats = state.stats
    stats.losses += 1
    stats.streak = 0
    
    state.stats = stats
    return state
}



func handleSubmit(state: AppState) -> AppState {
    var state = state
    let currentGuess = state.currentGuess
    
    if (state.gameState.gameOver) {
        // Don't handle keyboard input if game is over
        return state
    }
    
    if let error = checkForErrors(state: state) {
        state.error = error
        
        return state
    }
    
    // MARK: Process genuine guess
    state.previousGuesses.append(currentGuess)
    
    state.attemptedLetters = markAttemptedLetters(attemptedLetters: state.attemptedLetters, currentGuess: state.currentGuess, wordToGuess: state.wordToGuess)
    
    // MARK: Check to see if game is over
    
    if(currentGuess == state.wordToGuess) {
        state = handleWin(state:state)
    }
    else if(state.previousGuesses.count >= state.maxGuesses){
        state = handleLoss(state: state)
    }
    
    state.currentGuess = ""

    return state
}

