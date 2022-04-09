import SwiftUI

struct StatsSummaryView: View {
    let stats: Stats
    var showStreak:Bool = true
    
    var body: some View {
        VStack {
            Text("Wins "+String(stats.wins))
            Text("Losses "+String(stats.losses))
            if(showStreak) {
                Text("Streak "+String(stats.streak))
            }
        }
    }
}

struct StatsSummaryView_Previews: PreviewProvider {
    static var stats = Stats()
    
    static var previews: some View {
        StatsSummaryView(stats: stats)
        StatsSummaryView(stats: stats, showStreak: false)
    }
}
