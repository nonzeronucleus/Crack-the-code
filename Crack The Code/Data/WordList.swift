import Foundation

class WordList {
    let shortList:[String]
    let longlist:[String]
    var possibleAnswers:[String] = []
    var userWordList:[String] = []
    var wordToGuess: String = ""

    init() {
        shortList = WordList.loadFile("ukenglish")
        longlist = WordList.loadFile("ukenglonglist")        
    }
    
    func startGame(maxLetters:Int, useHardWords:Bool) {
        possibleAnswers = useHardWords // answer will be based on user option
            ? longlist.filter({$0.count == maxLetters})
            : shortList.filter({$0.count == maxLetters})
        
        userWordList = longlist.filter({$0.count == maxLetters})
        
        self.wordToGuess = possibleAnswers[Int.random(in: 0..<possibleAnswers.count)]

    }
    
    static private func loadFile(_ name:String) -> [String] {
        guard let file = Bundle.main.url(forResource: name, withExtension: "txt")
        else {
            fatalError("Failed file")
        }
        do {
            let data = try String(contentsOfFile:file.path, encoding: String.Encoding.ascii)
            return data.components(separatedBy: "\n")
        }
        catch let err as NSError {
            fatalError(err.description)
        }
    }
}
