func getGuessLengths(guessedLengths:[Int]?, maxGuesses:Int) -> [Int] {
    if var guessedLengths = guessedLengths {
        if(guessedLengths.count<maxGuesses) {
            // Array isn't currently long enough for the maximum number of guesses allowed. Add elements of array
            let extra = [Int](repeating: 0, count: maxGuesses-guessedLengths.count)
            guessedLengths += extra
        }
        return guessedLengths
    }
    else {
        // We don't have any guesses yet
       return [Int](repeating: 0, count: maxGuesses)
    }
}
