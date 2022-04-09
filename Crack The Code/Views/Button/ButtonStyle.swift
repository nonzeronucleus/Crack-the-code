import SwiftUI



struct ButtonStyle: View {
    var label: String
    
    init(_ label:String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .padding(.leading,16)
            .padding(.trailing,16)
            .padding(.top,8)
            .padding(.bottom,8)
            .foregroundColor(Color.primary)
            .background(Color(UIColor.systemFill))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                .stroke(Color.primary, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            .padding(.top,8)
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle("Test")
        ButtonStyle("Test")
            .preferredColorScheme(.dark)
    }
}
