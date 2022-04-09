import Foundation
import ReSwift

fileprivate func getWordToGuess(maxLetters:Int = 5) -> String {
    let possibleAnswers = WordList.short.filter{$0.count == maxLetters}
    
    return possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]
}



func handleStartGame(_ state:AppState) -> AppState {
    var state = state
    
    state.currentGuess = ""
    state.previousGuesses = []
    state.attemptedLetters = AttemptedLetters()
    
    state.wordToGuess = getWordToGuess()
    state.gameState = .inProgress
    
    log(state.wordToGuess)
    
    return state
}
