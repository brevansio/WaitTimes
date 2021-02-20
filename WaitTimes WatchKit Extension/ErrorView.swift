//
//  ErrorView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

struct ErrorView: View {
    var error: Error

    var body: some View {
        Text("Error")
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum PreviewError: Error { 
        case unableToConnect
    }
    static var previews: some View {
        ErrorView(error: PreviewError.unableToConnect)
    }
}
