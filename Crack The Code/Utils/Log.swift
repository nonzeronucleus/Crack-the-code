import Foundation

enum LogType:String {
    case error = "📕"
    case warn = "📙"
    case ok = "📗"
    case action = "📘"
    case canceled = "📓"
    case note = "📔"
}

class Timestamp {
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
        return formatter
    }()

    func timeStamp () -> String {
        return (dateFormatter.string(from: Date()))
    }
}

// usage - var _ = log(state.attemptedLetters, type: .error)

fileprivate var depth = 0

func log(_ expression: @autoclosure () -> Any, type:LogType = .note, file:String = #file, function:String = #function, line:Int = #line) {
    #if DEBUG
    let fileSections = file.components(separatedBy: "/")
    let fileName = fileSections[fileSections.count-1]
    

    var t = ""
    
    for _ in 0..<depth {
        t+="\t"
    }

    print(t, type.rawValue + fileName ,":" ,function + "(" + line.description + ")",":" , Timestamp().timeStamp())
    depth+=1
    
    print(t+"\t", expression())
    
    depth-=1
    print(t, type.rawValue)

    #endif
}
