//
//  ErrorView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 31/03/2022.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject private var state = ObservableState(store: mainStore);
//    @ObservedObject var error: ErrorTracker
    
//    init(_ error:ErrorTracker) {
//        self.error = error
//    }
//
    var body: some View {
        VStack {
            if let msg = state.current.error {
                Text(msg)
            }
            else {
                Text(" ")
            }
        }
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
