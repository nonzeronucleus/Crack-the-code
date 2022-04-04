import SwiftUI


struct LetterKey: View{
    let char: Character?
    let onClick: () -> Void
    let color:Color

    init(_ char:Character?,
         color: Color,
         onClick:@escaping () -> Void
    ) {
        self.char = char
        self.onClick = onClick
        
        self.color = color
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing:0)
            {
                if let letterToShow = char {
                    Button {
                        onClick()
                    } label: {
                        Letter(char: String(letterToShow), color: color)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                } else {
                    Letter(char: String(" "), color:color, fontColor: Color.secondary)
                }
            }
        }
    }
}


struct LetterKey_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            HStack {
                LetterKey("A", color:  Color(UIColor.systemBackground), onClick: {})
                LetterKey("B", color:  Color(UIColor.systemBackground), onClick: {})
                LetterKey("C", color:  Color(UIColor.systemBackground), onClick: {})
            }
        }
    }
}
