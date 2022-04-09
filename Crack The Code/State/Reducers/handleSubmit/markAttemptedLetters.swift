func markAttemptedLetters(attemptedLetters:AttemptedLetters, currentGuess:String, wordToGuess:String) -> AttemptedLetters {
    let overlap = currentGuess.overlap(with: wordToGuess)
    
    if ((overlap.exact.count + overlap.inWord.count) > 0) {
        // At least one of these letters is in the target word
        for char in currentGuess {
            attemptedLetters.setStatus(char, status:.POSSIBLE)
        }
    }
    else {
        // All letters wrong
        for char in currentGuess {
            attemptedLetters.setStatus(char, status: .NOT_IN_WORD)
        }
    }
    
    return attemptedLetters
}
