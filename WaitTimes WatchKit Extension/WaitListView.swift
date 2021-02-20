//
//  WaitListView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

struct WaitListView: View {
    @ObservedObject var viewModel: FacilityDataModel
    
    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().onAppear(perform: { viewModel.load() })
        case .failure(let error):
            ErrorView(error: error)
        case .loaded(let facilities):
            LazyVGrid(columns: [GridItem(.fixed(200))]) {
                ForEach(facilities) { facility in
                    FacilityView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaitListView(viewModel: FacilityDataModel(location: .land))
    }
}
