import Foundation

class GameState: ObservableObject {
    let guessTracker: GuessTracker
    
    init() {
        guessTracker = GuessTracker()
    }
}
