//
//  WaitListView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

private extension Color {
    static let tdlTheme = Color(.displayP3, red: 197, green: 135, blue: 164, opacity: 1)
    static let tdsTheme = Color(.displayP3, red: 95, green: 135, blue: 141, opacity: 1)
}

struct WaitListView: View {
    @ObservedObject var viewModel: FacilityDataModel
    
    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().onAppear(perform: { viewModel.load() })
        case .failure(let error):
            ErrorView(error: error)
        case .loaded(let facilities):
            ScrollView {
                switch viewModel.location {
                case .land:
                    Text("Land")
                        .font(.title3)
                        .foregroundColor(.tdlTheme)
                case .sea:
                    Text("Sea")
                        .font(.title3)
                        .foregroundColor(.tdsTheme)
                }
                LazyVGrid(columns: [GridItem(.fixed(200))]) {
                    ForEach(facilities.filter({ $0.standByTime > 0 })) { facility in
                        FacilityView(facility: facility)
                            .padding()
                    }
                }
            }
            .onLongPressGesture {
                viewModel.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaitListView(viewModel: FacilityDataModel(location: .land))
    }
}
