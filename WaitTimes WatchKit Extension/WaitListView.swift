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

    @State private var maxWidth: CGFloat?
    
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
                    .scaledToFit()
                    .frame(width: maxWidth)
                Text("\(error.localizedDescription)")
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Button("再試行する") {
                    viewModel.load()
                }
            }
            .background(GeometryReader { geometry in
                Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
            })
            .onPreferenceChange(WidthPreferenceKey.self) {
                maxWidth = $0
            }
        case .loaded(let facilities):
            ScrollView {
                VStack {
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

                    LazyVGrid(columns: [GridItem(.fixed(maxWidth ?? 0))]) {
                        ForEach(facilities.filter({ guard !filter.isEmpty else { return true }
                                                    return $0.name.contains(filter) })) { facility in
                            FacilityView(facility: facility)
                                .padding(.bottom, 10)
                        }
                    }

                    switch viewModel.location {
                    case .land:
                        Button("更新") {
                            viewModel.load()
                        }
                        .background(Color.tdlTheme)
                        .cornerRadius(8)
                        .frame(width: maxWidth)
                    case .sea:
                        Button("更新") {
                            viewModel.load()
                        }
                        .background(Color.tdsTheme)
                        .cornerRadius(8)
                        .frame(width: maxWidth)
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                })
                .onPreferenceChange(WidthPreferenceKey.self) {
                    maxWidth = $0
                }
            }

        }
    }
}

extension WaitListView {
    struct WidthPreferenceKey: PreferenceKey {
        static let defaultValue: CGFloat = 0

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaitListView(viewModel: FacilityDataModel(location: .land))
    }
}
