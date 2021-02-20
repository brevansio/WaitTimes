//
//  WaitTimesApp.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

@main
struct WaitTimesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WaitListView(viewModel: FacilityDataModel(location: .land))
            }
        }
    }
}
