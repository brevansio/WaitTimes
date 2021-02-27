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

    var landImageDataModel = ImageNetworkModel()
    var seaImageDataModel = ImageNetworkModel()

    @StateObject var landModel = FacilityNetworkModel(location: .land)
    @StateObject var seaModel = FacilityNetworkModel(location: .sea)


    var body: some Scene {
        WindowGroup {
            TabView {
                LoadingView(viewModel: landModel).environmentObject(landImageDataModel)
                LoadingView(viewModel: seaModel).environmentObject(seaImageDataModel)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear(perform: {
                landImageDataModel.loadImages(for: .land)
                seaImageDataModel.loadImages(for: .sea)
            })
            .onChange(of: scenePhase, perform: { newPhase in
                if newPhase == .active {
                    landModel.load()
                    seaModel.load()

                    if landImageDataModel.imageData.isEmpty {
                        landImageDataModel.loadImages(for: .land)
                    }

                    if seaImageDataModel.imageData.isEmpty {
                        seaImageDataModel.loadImages(for: .sea)
                    }
                }
            })
        }
    }
}
