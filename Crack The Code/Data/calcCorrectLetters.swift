import Foundation

func calcCorrectLetters(wordToGuess:String, guess:String) -> (correctPos:Int, wrongPos:Int){
    var lettersToGuess = Array(wordToGuess)
    var guessedLetters = Array(guess)
    var correctPos = 0
    var wrongPos = 0

    // Check for letters in correct position
    for idx in 0...lettersToGuess.count-1 {
        if(lettersToGuess[idx] == guessedLetters[idx]) {
            lettersToGuess[idx] = " "
            guessedLetters[idx] = "."
            correctPos += 1
        }
    }
    
    // Check for letters in wrong
    for idx in 0...lettersToGuess.count-1 {
        if let loc = guessedLetters.firstIndex(of: lettersToGuess[idx]) {
            lettersToGuess[idx] = " "
            guessedLetters[loc] = "."
            wrongPos += 1
        }
    }

    return (correctPos:correctPos, wrongPos:wrongPos)
}
