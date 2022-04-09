//
//  InfoView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 06/04/2022.
//

import SwiftUI


fileprivate struct Para: View {
    private let text:String
    
    init(_ text:String) {
        self.text = text
    }
    
    var body: some View {
        HStack{
            Text(text)
            .font(.body)
            .padding(.bottom,10)
            Spacer()
        }
    }
}

struct InfoView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        ScrollView {
            VStack {

                Text("How To Play")
//                    .font(.title)
                    .padding(10)
                
                Para("The objective of the game is to guess the correct word. Choose a " + String(state.current.wordLength) + " letter word and press enter. You will be shown how many correct letters you have found.")
                HStack{
                    Text("✓").foregroundColor(.green).frame(width: 30)
                    Text("Number of letters in the right place")
                    Spacer()
                }
                .padding(.bottom,10)

                HStack{
                    Text("?").foregroundColor(.orange).frame(width: 30)
                    Text("Number of letters in the wrong place")
                    Spacer()
                }
                .padding(.bottom,10)
                
                Para("Keys on the keyboard will show letters that you have attempted")

                HStack{
                    Letter(char: "A", color: GameColors.somewhere.background).frame(width: 30, height: 30)
                    Text("Letter could be in word")
                    Spacer()
                }
                .padding(.bottom,10)

                HStack{
                    Letter(char: "A", color: GameColors.wrong.background).frame(width: 30, height: 30)
                    Text("Letter not in word")
                    Spacer()
                }
                .padding(.bottom,10)

            }
            .padding(20)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
