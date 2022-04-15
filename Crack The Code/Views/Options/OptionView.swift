//
//  OptionView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 13/04/2022.
//

import SwiftUI

struct OptionView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        VStack {
            HStack {
                Button {
                    state.dispatch(SetGameModeAction(mode: .letters))
                } label: {
                    Text("Letter Mode")
                }
                Button {
                    state.dispatch(SetGameModeAction(mode: .numbers))
                } label: {
                    Text("Number Mode")
                }
            }
            NewGameButton()
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
            .environmentObject( createStore()) //ObservableState(store: mainStore))
    }
}
