//
//  FacilityView.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import SwiftUI

private extension Color {
    static let mickeyRed = Color(.displayP3, red: 242 / 255, green: 5 / 255, blue: 5 / 255, opacity: 1)
    static let mickeyYellow = Color(.displayP3, red: 219 / 255, green: 215 / 255, blue: 11 / 255, opacity: 1)
    static let mickeyBlack = Color(.displayP3, red: 25 / 255, green: 25 / 255, blue: 25 / 255, opacity: 1)
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
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(2)
                HStack {
                    if let operatingStatus = facility.operatingStatus {
                        Text(operatingStatus)
                            .foregroundColor(.mickeyYellow)
                            .font(.headline)
                            .bold()
                            .frame(alignment: .leading)
                            .padding()
                        Spacer()
                    }
                    if facility.standByTime > 0 {
                        Spacer()
                        Text("\(facility.standByTime)分待ち")
                            .foregroundColor(.mickeyYellow)
                            .font(.headline)
                            .bold()
                            .frame(alignment: .trailing)
                            .padding()
                    }
                }
            }
        }
        .background(Color.mickeyBlack)
        .cornerRadius(15.0)
    }
}
