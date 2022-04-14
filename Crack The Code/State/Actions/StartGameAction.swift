import ReSwift

func triggerGameStart(wordLength:Int) -> StartGameAction {
    let possibleAnswers = WordList.short.filter{$0.count == wordLength}
    
    let wordToGuess = possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]
    return StartGameAction(wordToGuess: wordToGuess)
}

struct StartGameAction: Action {
    var wordToGuess: String
}
