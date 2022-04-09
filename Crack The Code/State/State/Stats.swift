
struct Stats:Codable {    
    enum CodeKeys: CodingKey {
        case wins, losses, streak, guessedLengths
    }
    
    init() {
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodeKeys.self)
        wins = try values.decode(Int.self, forKey: .wins)
        losses = try values.decode(Int.self, forKey: .losses)
        streak = try values.decode(Int.self, forKey: .streak)
        guessedLengths = try values.decodeIfPresent([Int].self, forKey: .guessedLengths)
    }

    var wins = 0
    var losses = 0
    var streak = 0
    var guessedLengths:[Int]? = nil
}
