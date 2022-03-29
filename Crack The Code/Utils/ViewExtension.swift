import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
//    func foregroundColor(_ color: GameColors) -> some View {
//            return self.foregroundColor(color.foregroundColor)
//    }

    func colors(_ color: GameColors) -> some View {
            return modifier(GameColorView(color: color))
    }
}


//func watermarked(with text: String) -> some View {
//    modifier(Watermark(text: text))
//}


struct GameColorView: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
    
    var color: GameColors
}
