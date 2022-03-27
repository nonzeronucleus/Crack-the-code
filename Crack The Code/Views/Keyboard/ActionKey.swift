import SwiftUI


struct ActionKey: View{
    let keyText: String
    let onClick: () -> Void
    var fontScale: Double
    
    
    init(_ keyText:String,
         onClick:@escaping () -> Void,
         fontScale: Double
    ) {
        self.keyText = keyText
        self.onClick = onClick
        self.fontScale = fontScale
    }
    
    var body: some View {
        GeometryReader { geo in
            Button {
                onClick()
            } label: {
                Letter(char: keyText, color: Color.cyan, fontScale: fontScale)
            }
//            .buttonStyle(.plain)
        }
    }
}


struct ActionKey_Previews: PreviewProvider {
    static var previews: some View {
        ActionKey("X", onClick: {}, fontScale: 0.5)
    }
}
