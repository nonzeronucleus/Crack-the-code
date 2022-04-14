//
//  ContentView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 27/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Crack The Code")
                        .font(Font.custom("SFUIDisplay-Light", size: 21))

                    Spacer()
                    NavigationLink(destination: DebugView( )) {
                        Image(systemName: "ant.circle")
                            .foregroundColor(.primary)
                            .font(Font.custom("SFUIDisplay-Light", size: 21))
                    }
                    
                    NavigationLink(destination: StatsView( )) {
                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(.primary)
                            .font(Font.custom("SFUIDisplay-Light", size: 21))
                    }
                    
                    NavigationLink(destination: InfoView()) { //InfoView
                        Image(systemName: "info.circle")
                            .foregroundColor(.primary)
                            .font(Font.custom("SFUIDisplay-Light", size: 21))
                    }

                    NavigationLink(destination: OptionView()) { 
                        Image(systemName: "gear")
                            .font(Font.custom("SFUIDisplay-Light", size: 21))
                    }
                    .buttonStyle(.plain)
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("Title", displayMode: .inline)
                }
                .font(.largeTitle)
                .navigationTitle("Back")
                .padding()



                GameView()
                    .navigationBarHidden(true)
            }
        }.navigationBarTitle(Text("ContentView"))
           .navigationViewStyle(StackNavigationViewStyle() )
    }
}


//func numericState() -> AppState {
//    var state = AppState()
//    
//    return state
//}
//
//
struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .environmentObject( createStore()) //ObservableState(store: mainStore))
    }
}
