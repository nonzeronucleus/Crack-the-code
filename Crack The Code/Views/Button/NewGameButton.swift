import SwiftUI

fileprivate struct NewGameButtonImpl: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            ButtonStyle("New Game")
        }
    }
}

struct NewGameButton: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    var body: some View {
        NewGameButtonImpl(action: {
            state.dispatch(triggerGameStart(wordLength: state.current.wordLength))
        })
    }
}


struct NewGameButton_Previews: PreviewProvider {
    static var previews: some View {
        NewGameButtonImpl(action: {})
    }
}
