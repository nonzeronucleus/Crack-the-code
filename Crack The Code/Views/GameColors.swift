import SwiftUI

enum GameColors:Int {
    case empty, wrong, inWord, correctPosition, somewhere, cardBack
    
    var background:Color {
        get {
            switch self {
            case .empty,.cardBack:
                return Color(UIColor.systemBackground)
            case .wrong:
                return Color(UIColor.lightGray)
            case .inWord:
                return .yellow
            case .correctPosition:
                return .green
            case .somewhere:
                return .orange
            }
        }
    }

    var foregroundColor:Color {
        get {
            switch self {
            case .empty,.cardBack:
                return .primary
            case .wrong:
                return .black
            case .inWord:
                return .black
            case .correctPosition:
                return .black
            case .somewhere:
                return .black
            }
        }
    }


}
