//
//  WaitTimesApp.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

@main
struct WaitTimesApp: App {
    var landImageDataModel = ImageDataModel()
    var seaImageDataModel = ImageDataModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                WaitListView(viewModel: FacilityDataModel(location: .land)).environmentObject(landImageDataModel)
                WaitListView(viewModel: FacilityDataModel(location: .sea)).environmentObject(seaImageDataModel)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear(perform: {
                landImageDataModel.loadImages(for: .land)
                seaImageDataModel.loadImages(for: .sea)
            })
        }
    }
}
