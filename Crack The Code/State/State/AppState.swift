import SwiftUI
import ReSwift


// MARK: - Main state

struct AppState: Codable {
    
    init() {
        stats = Stats()
        wordLength = 5
        maxGuesses = 12
        
        error = nil
        wordToGuess = ""
        
        currentGuess = ""
        previousGuesses = []
        gameState = .notStarded
        attemptedLetters = AttemptedLetters()
    }
    

    enum CodeKeys: CodingKey {
        case stats,wordLength,maxGuesses,error,wordToGuess,currentGuess,previousGuesses,gameState,attemptedLetters
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodeKeys.self)
        stats = try values.decode(Stats.self, forKey: .stats)
        wordLength = try values.decode(Int.self, forKey: .wordLength)
        maxGuesses = try values.decode(Int.self, forKey: .maxGuesses)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        wordToGuess = try values.decode(String.self, forKey: .wordToGuess)
        currentGuess = try values.decode(String.self, forKey: .currentGuess)
        previousGuesses = try values.decode([String].self, forKey: .previousGuesses)
        gameState = try values.decode(GameStatus.self, forKey: .gameState)
        attemptedLetters = try values.decode(AttemptedLetters.self, forKey: .attemptedLetters)
    }
    
    func toString() -> String {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(self)
            if let str = String(data: jsonData, encoding: String.Encoding.utf8) {
                return str
            }
            return "Could not convert"
        }
        catch {
            return error.localizedDescription
        }
    }
    
    var stats = Stats()
    var wordLength = 5
    var maxGuesses = 12
    
    var error: String? = nil
    var wordToGuess = ""
    
    var currentGuess = ""
    var previousGuesses:[String] = []
    var gameState: GameStatus = .notStarded
    var attemptedLetters:AttemptedLetters = AttemptedLetters()
}



