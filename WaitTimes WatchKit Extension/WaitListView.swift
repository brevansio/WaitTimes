//
//  WaitListView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/27.
//

import SwiftUI

private extension Color {
    static let tdlTheme = Color(.displayP3, red: 197 / 255, green: 135 / 255, blue: 164 / 255, opacity: 1)
    static let tdsTheme = Color(.displayP3, red: 95 / 255, green: 135 / 255, blue: 141 / 255, opacity: 1)
}

struct WaitListView: View {
    @ObservedObject var viewModel: FacilityNetworkModel
    var onRefresh: () -> Void

    @State private var filter = ""

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(viewModel.location == .land ? "Land" : "Sea")
                        .foregroundColor(viewModel.location == .land ? .tdlTheme : .tdsTheme)
                        .font(.title3)
                        .bold()
                    TextField("検索", text: $filter)
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.filter(with: filter)) { facility in
                        FacilityView(facility: facility)
                            .padding(.bottom, 10)
                    }
                }
                Button("更新") {
                    filter = ""
                    onRefresh()
                }
                .background(viewModel.location == .land ? Color.tdlTheme : Color.tdsTheme)
                .cornerRadius(8)
            }
        }
    }
}

struct FacilityList_Previews: PreviewProvider {
    static var previews: some View {
        WaitListView(viewModel: FacilityNetworkModel(location: .land)) {
            // Noop
        }
    }
}
