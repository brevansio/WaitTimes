//
//  WaitTimesApp.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

@main
struct WaitTimesApp: App {
    @Environment(\.scenePhase) private var scenePhase

    var landImageDataModel = ImageDataModel()
    var seaImageDataModel = ImageDataModel()

    var landFacilityDataModel = FacilityDataModel(location: .land)
    var seaFacilityDataModel = FacilityDataModel(location: .sea)


    var body: some Scene {
        WindowGroup {
            TabView {
                WaitListView(viewModel: landFacilityDataModel).environmentObject(landImageDataModel)
                WaitListView(viewModel: seaFacilityDataModel).environmentObject(seaImageDataModel)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear(perform: {
                landImageDataModel.loadImages(for: .land)
                seaImageDataModel.loadImages(for: .sea)
            })
            .onChange(of: scenePhase, perform: { newPhase in
                if newPhase == .active {
                    landFacilityDataModel.load()
                    seaFacilityDataModel.load()
                }
            })
        }
    }
}
