//
//  ColorBoard.swift
//  Crack The Code
//
//  Created by Ian Plumb on 27/03/2022.
//

import SwiftUI

struct ColorBoard: View {
    let spacing = 2.0
    private var colors:[Color]
    
    init(_ colors:[Color]){
        self.colors = colors
    }
    
    var body: some View {

        GeometryReader { geo in
            let buttonWidth = abs((geo.size.width/maxKeysPerRow)-spacing)
            
            HStack (spacing:spacing) {
                Spacer(minLength: 0)
                
                ActionKey("⌫",
                    onClick: {},
                    fontScale:0.6)
                    .frame(width:buttonWidth, height: buttonWidth, alignment:.center)
                
                ForEach(colors, id:\.self) { color in
                    LetterKey(nil, onClick: {}, color:color)
                        .frame(width: buttonWidth, height: buttonWidth, alignment:.center)
                }
                ActionKey("⏎",
                    onClick: {},
                    fontScale:0.5)
                    .frame(width: buttonWidth, height: buttonWidth, alignment:.center)

                Spacer(minLength: 0)
            }
        }
    }
}

struct ColorBoard_Previews: PreviewProvider {
    static var colors:[Color] = [
        .red,
        .blue,
        .green,
        .purple,
        .orange,
        .yellow
    ]
    
    static var previews: some View {
        ColorBoard(colors)
    }
}
