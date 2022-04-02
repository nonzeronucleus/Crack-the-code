import SwiftUI
import ReSwift

// MARK: ReSwift Example Setup


struct AppState {
    var error: String? = nil
    var wordToGuess = ""
    var currentGuess = ""
    var previousGuesses:[String] = []
    var wordLength = 5
}


struct startGame: Action {}

struct addCharacter: Action {var char:Character}
struct deleteCharacter: Action {}
struct submitGuess: Action {}




func handleSubmit(state: AppState) -> AppState {
    var state = state
    let currentGuess = state.currentGuess
    let wordLength = state.wordLength
    let previousGuesses = state.previousGuesses
    
    if (currentGuess.count<wordLength) {
        state.error = "Word too short"
        return state
    }
    
    if (previousGuesses.contains(where: {$0 == currentGuess})) {
        state.error = "Word already guessed"
        return state
    }
        
    state.previousGuesses.append(currentGuess)
    state.currentGuess = ""

    return state
}

func deleteChar(_ text:String) -> String {
    if (text.count == 0) {
        // String is empty
        return text
    }
   return String(text.prefix(text.count-1))
}

func getWordToGuess(maxLetters:Int = 5) -> String {
    let possibleAnswers = WordList.short.filter{$0.count == maxLetters}
    
    return possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]
}

func handleStartGame(_ state:AppState) -> AppState {
    var state = state
    
    state.currentGuess = ""
    state.previousGuesses = []
    state.wordToGuess = getWordToGuess()
    
    log(state.wordToGuess)
    
    return state
}

func handleCurrentGuess(action: Action, state: AppState) -> AppState {
    var state = state
    
    switch action {
        // Mark: current guess
    case let addChar as addCharacter:
        if (state.currentGuess.count<state.wordLength) {
            state.currentGuess.append(addChar.char)
        }
    case _ as deleteCharacter:
        state.currentGuess = deleteChar(state.currentGuess)
    default:
        break
    }
    
    return state
}



func reducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    state.error = nil

    switch action {
        // Mark : Game management
    case _ as startGame:
        state = handleStartGame(state)
        
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



let mainStore = Store<AppState>(
    reducer: reducer,
    state: nil
)
