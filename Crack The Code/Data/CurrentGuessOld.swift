//import Foundation
//
//class CurrentGuessOld: ObservableObject {
//    @Published var guess:String = ""
//    var length:Int = 0
//    private var guessTracker: GuessTracker?
//    private var error:ErrorTracker
//    
//    
//    init(length: Int, error:ErrorTracker) {
//        self.length = length
//        self.error = error
//    }
//    
//    convenience init(length:Int, guess:String, error:ErrorTracker) {
//        self.init(length:length, error:error)
//        self.guess = guess
//    }
//    
//    func setTracker(_ guessTracker:GuessTracker) {
//        self.guessTracker = guessTracker
//    }
//    
//    func append(char:Character) {
//        error.clear()
//        if(guess.count<length) {
//            guess.append(char)
//        }
//    }
//    
//    func delete() {
//        if (!guess.isEmpty) {
//            guess = String(guess.prefix(guess.count-1))
//        }
//    }
//    
//    func submitGuess() {
//        if let guessTracker = guessTracker {
//            if isComplete {
//                if guessTracker.submitGuess() {
//                    guess = ""
//                }
//            }
//            else {
//                error.set("Guess is too short")
//            }
//        }
//    }
//    
//    var isComplete: Bool {
//        get {
//            return (guess.count == length)
//        }
//    }
//}
