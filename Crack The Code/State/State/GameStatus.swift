import Foundation

enum GameStatus:String, Codable {
    case notStarded = "S"
    case inProgress = "In progress"
    case won = "Won"
    case lost = "Lost"
    case extraGo = "Extra Go"
    case stillLost = "Given Up"
    case revealAnswer = "Reveal Answer"
    
    var gameOver:Bool {
        get {
            return (self == .won || self == .lost)
        }
    }
}
