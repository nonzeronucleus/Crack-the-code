import SwiftUI



struct StatsView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

    @State private var confirming:Bool = false
    
    init() {
//        gameMode = Settings.shared.gameMode
    }

    var body: some View {
        VStack {
            Text("Game Stats").bold()
//            GameModePicker(gameModeField: $gameMode, type:.all).padding()

//            if let currentStats = statsMgr.stats(forMode: gameMode) {
            StatsSummaryView(stats: state.current.stats)
//
//                if let maxGuesses = gameMode.maxGuesses {
//                    if (!confirming) {
            GuessLengthView(maxGuesses: state.current.maxGuesses, guessedLengths: state.current.stats.guessedLengths)
//                    }
//                }
//            }
            HStack {
                Spacer()
//                ResetStatsButton(mode: gameMode, confirming:$confirming)
                Spacer()
            }
            Spacer()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject( ObservableState(store: mainStore))
    }
}
