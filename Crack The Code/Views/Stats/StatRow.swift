import SwiftUI


struct Bar: View {
//    var count:Int
//    var max:Int
    var ratio:Double
    
    init(count:Int, max:Int) {
//        self.count = count
        ratio = max > 0 ? Double(count)/Double(max) : 0
    }

    var body: some View {
        GeometryReader { geo in
            HStack(spacing:0) {
                Color.red
                    .frame(width: geo.size.width * ratio, height: geo.size.height, alignment: .topLeading)
                Color.clear
                    .frame(width: geo.size.width * (1.0-ratio), height: geo.size.height, alignment: .topLeading)
            }
        }
    }
}





struct StatRow: View {
    var count:Int
    var max:Int
    var label:String
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        Text(label)
                            .frame(width: 30)
                    }

                    Bar(count: count, max: max)

                    Spacer()
                    
                    Text(String(count))
                }
            }.frame(width: geo.size.width * 1, height: geo.size.height, alignment: .topLeading)
        }
        .frame(height: 20 )
    }
}



struct Bar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatRow(count: 2, max: 17,  label: "1:")
            StatRow(count: 0, max: 17, label: "2:")
            StatRow(count: 17, max: 17, label: "3:")
            Spacer()
        }
    }
}
