//
//  FacilityView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

private extension Color {
    static let mickeyRed = Color(.displayP3, red: 242, green: 5, blue: 5, opacity: 1)
    static let mickeyYellow = Color(.displayP3, red: 219, green: 215, blue: 11, opacity: 1)
    static let mickeyBlack = Color(.displayP3, red: 0, green: 0, blue: 0, opacity: 1)
}

struct FacilityView: View {
    var facility: Facility

    var body: some View {
        VStack {
            Image("\(facility.code)")
                .resizable()
                .cornerRadius(15.0)
            VStack {
                Text(facility.name)
                    .foregroundColor(.mickeyYellow)
                    .font(.subheadline)
                    .lineLimit(2)
                if facility.standByTime > 0 {
                    Text("\(facility.standByTime)分")
                        .foregroundColor(.mickeyYellow)
                        .font(.headline)
                }
            }
        }
        .background(Color.mickeyBlack)
        .cornerRadius(3.0)
    }
}
