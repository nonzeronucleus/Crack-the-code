//
//  ErrorView.swift
//  Crack The Code
//
//  Created by Ian Plumb on 31/03/2022.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject private var state:ObservableState<AppState>

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
