//
//  WaitListView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

private extension Color {
    static let tdlTheme = Color(.displayP3, red: 197 / 255, green: 135 / 255, blue: 164 / 255, opacity: 1)
    static let tdsTheme = Color(.displayP3, red: 95 / 255, green: 135 / 255, blue: 141 / 255, opacity: 1)
}

struct WaitListView: View {
    @ObservedObject var viewModel: FacilityDataModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            ProgressView().onAppear(perform: { viewModel.load() })
        case .loading:
            ProgressView()
        case .failure(let error):
            VStack {
                Image("error")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150)
                Text("Error: \(error.localizedDescription)")
                    .lineLimit(2)
                Button("Retry") {
                    viewModel.load()
                }
            }
        case .loaded(let facilities):
            ScrollView {
                switch viewModel.location {
                case .land:
                    Text("Land")
                        .foregroundColor(.tdlTheme)
                        .font(.title3)
                        .bold()
                case .sea:
                    Text("Sea")
                        .foregroundColor(.tdsTheme)
                        .font(.title3)
                        .bold()
                }

                LazyVGrid(columns: [GridItem(.fixed(200))]) {
                    ForEach(facilities) { facility in
                        FacilityView(facility: facility)
                            .padding()
                    }
                }
                .padding()

                switch viewModel.location {
                case .land:
                    Button("更新") {
                        viewModel.load()
                    }
                    .buttonStyle(LandButtonStyle())
                case .sea:
                    Button("更新") {
                        viewModel.load()
                    }
                    .buttonStyle(SeaButtonStyle())
                }
            }
        }
    }
}

struct LandButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding()
        .background(Color.tdlTheme)
        .clipShape(Capsule())
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct SeaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
            Spacer()
        }
        .padding()
        .background(Color.tdsTheme)
        .clipShape(Capsule())
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaitListView(viewModel: FacilityDataModel(location: .land))
    }
}
