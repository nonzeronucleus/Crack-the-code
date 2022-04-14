import ReSwift

func createStartGameAction(state: AppState) -> StartGameAction {
    let wordLength = state.wordLength
    let mode = state.config.mode
    
    
    let possibleAnswers = WordList.short.filter{$0.count == wordLength}
    
    let wordToGuess = ( mode == .letters)
        ? possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]
        : "12345"
    
    return StartGameAction(wordToGuess: wordToGuess, mode:mode)
}

struct StartGameAction: Action {
    var wordToGuess: String
    var mode: Mode
}
