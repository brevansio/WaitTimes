//
//  ErrorView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/27.
//

import SwiftUI

struct ErrorView: View {
    var error: Error
    var onRefresh: () -> Void

    var body: some View {
        VStack {
            Image("error")
                .resizable()
                .scaledToFit()
            Text("\(error.localizedDescription)")
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Button("再試行する", action: onRefresh)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum PreviewError: Error {
        case test
    }

    static var previews: some View {
        ErrorView(error: PreviewError.test) {
            // Noop
        }
    }
}
