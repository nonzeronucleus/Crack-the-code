import Foundation

class CurrentGuess: ObservableObject {
    @Published var guess:String = ""
    var length:Int = 0
    private var guessTracker: GuessTracker?
    
    init(length: Int) {
        self.length = length
    }
    
    convenience init(length:Int, guess:String) {
        self.init(length:length)
        self.guess = guess
    }
    
    func setTracker(_ guessTracker:GuessTracker) {
        self.guessTracker = guessTracker
    }
    
    func append(char:Character) {
        if(guess.count<length) {
            guess.append(char)
        }
    }
    
    func delete() {
        if (!guess.isEmpty) {
            guess = String(guess.prefix(guess.count-1))
        }
    }
    
    func submitGuess() {
        if let guessTracker = guessTracker {
            if isComplete {
                guessTracker.submitGuess()
                guess = ""
            }
        }
    }
    
    var isComplete: Bool {
        get {
            return (guess.count == length)
        }
    }
}
