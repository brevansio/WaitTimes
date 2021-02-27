//
//  LoadingView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI
import String_Japanese

struct LoadingView: View {
    @ObservedObject var viewModel: FacilityNetworkModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            ProgressView().onAppear(perform: {
                viewModel.load()
            })
        case .loading:
            ProgressView()
        case .failure(let error):
            ErrorView(error: error) {
                viewModel.load()
            }
        case .loaded:
            WaitListView(viewModel: viewModel) {
                viewModel.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(viewModel: FacilityNetworkModel(location: .land))
    }
}
