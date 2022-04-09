class AttemptedLetters:Codable, Equatable {
    static func == (lhs: AttemptedLetters, rhs: AttemptedLetters) -> Bool {
        return lhs.attempts == rhs.attempts
    }
    
    enum CodeKeys: CodingKey
    {
         case attempts
    }

    private var attempts: Dictionary<String,LetterStatus> = [:]

    init() {}
    
    convenience init(attempts:Dictionary<String,LetterStatus>) {
        self.init()
        self.attempts = attempts
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodeKeys.self)
        attempts = try values.decode(Dictionary<String,LetterStatus>.self, forKey: .attempts)
    }

    func setStatus(_ char:Character, status:LetterStatus) {
        let storeableChar = String(char)
        if attempts[storeableChar] == nil || status == .NOT_IN_WORD{
            attempts[storeableChar] = status
        }
    }
    
    func getStatus(_ char: Character) -> LetterStatus? {
        let storeableChar = String(char)
        
        return attempts[storeableChar]
    }
    
    func toString() -> String {
        var str = ""
        attempts.forEach { (key: String, value: LetterStatus) in
            let newStr = "{"+key+","+value.rawValue+"}"+","
            str.append(newStr)
        }
        
        return str
    }
    
    
}
