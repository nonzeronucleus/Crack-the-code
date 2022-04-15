import Foundation
import ReSwift


func power(radix:Int, power:Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func getRandomNum(wordLength:Int) -> String {
    let maxNum = power(radix: 10, power: wordLength)
    let val = Int.random(in: 0..<maxNum)
    let str = String(repeating: "0", count: wordLength) + String(val)
    
    return str.substring(from: str.count - wordLength)
}

func createStartGameAction(state: AppState) -> StartGameAction {
    let wordLength = state.wordLength
    let mode = state.config.mode
    
    
    let possibleAnswers = WordList.short.filter{$0.count == wordLength}
    
    let wordToGuess = ( mode == .letters)
        ? possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]
        : getRandomNum(wordLength:wordLength)
    
    return StartGameAction(wordToGuess: wordToGuess, mode:mode)
}

struct StartGameAction: Action {
    var wordToGuess: String
    var mode: GameMode
}
