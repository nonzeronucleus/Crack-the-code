import Foundation

struct PrevGuess : Hashable {
    var guess:String = ""
    var numLettersCorrectPos:Int
    var numLettersWrongPos:Int

    init(_ guess:String) {
        self.guess = guess
        numLettersCorrectPos = 0
        numLettersWrongPos = 0
    }
}

class GuessTracker:ObservableObject {
    var currentGuess:CurrentGuess
    @Published var prevGuesses:[PrevGuess] = []
    
    required init() {
        currentGuess = CurrentGuess(length: 5)
        currentGuess.setTracker(self)
    }
    
    func submitGuess() {
        if (currentGuess.isComplete) {
            prevGuesses.append(PrevGuess(currentGuess.guess))
        }
    }
}
