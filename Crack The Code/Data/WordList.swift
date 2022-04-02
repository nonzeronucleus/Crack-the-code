import Foundation

class WordList {
    static let short:[String]  = WordList.loadFile("ukenglish")
    static let long:[String] = WordList.loadFile("ukenglonglist")

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
