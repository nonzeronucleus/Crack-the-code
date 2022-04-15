//
//  OptionView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 13/04/2022.
//

import SwiftUI

struct OptionViewImpl: View {
    @State var mode:GameMode
    var setModeFn: (GameMode) -> Void
    
    init(mode:GameMode, setModeFn: @escaping (GameMode) -> Void) {
        self.mode = mode
        self.setModeFn = setModeFn
    }

    var body: some View {
        
        VStack {
            GroupBox(
                label: Label("Game Mode", systemImage: "keyboard")
                                .foregroundColor(.primary))
            {

                    Picker("Game Mode", selection: $mode) {
                        Text("Letters").tag(GameMode.letters)
                        Text("Numbers").tag(GameMode.numbers)
                    }
                    .pickerStyle(.segmented)
            }
            .onChange(of: mode)  {_ in
                setModeFn(mode)
            }
            NewGameButton()
            Spacer()
        }
    }
}

struct OptionView: View {
    @EnvironmentObject private var state:ObservableState<AppState>
    
    var body: some View {
        let setGameModeFn: (_ mode:GameMode) -> () = {state.dispatch(SetGameModeAction(mode: $0))}
        OptionViewImpl(mode: state.current.config.mode,
                       setModeFn: setGameModeFn)
    }
}


struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
            .environmentObject( createStore()) //ObservableState(store: mainStore))
    }
}
