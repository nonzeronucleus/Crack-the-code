import Foundation

func calcCorrectLetters(wordToGuess:String, guess:String) -> (correctPos:Int, wrongPos:Int){
    let overlap = guess.overlap(with: wordToGuess)
    
    return (correctPos:overlap.exact.count, wrongPos:overlap.inWord.count)
}
