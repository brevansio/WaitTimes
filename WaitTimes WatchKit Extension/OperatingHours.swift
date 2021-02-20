//
//  OperatingHours.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import Foundation

struct OperatingHours: Codable {
    let fromDate: Date
    let fromTime: String
    let toDate: Date
    let toTime: String
    let isSunset: Bool
    let statusCode: Int
    let statusString: String
    let isChanged: Bool

    enum CodingKeys: String, CodingKey {
        case fromDate = "OperatingHoursFromDate"
        case fromTime = "OperatingHoursFrom"
        case toDate = "OperatingHoursToDate"
        case toTime = "OperatingHoursTo"
        case isSunset = "SunsetFlg"
        case statusCode = "OperatingStatusCD"
        case statusString = "OperatingStatus"
        case isChanged = "OperatingChgFlg"
    }

    init(from decoder: Decoder) throws {
        func safelyDecodeDate(for key: CodingKeys, in container: KeyedDecodingContainer<OperatingHours.CodingKeys>) throws -> Date {
            // TODO: Does this need a performance boost?
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYYMMdd"

            do {
                 return try container.decode(Date.self, forKey: key)
            } catch {
                let dateString = try container.decode(String.self, forKey: key)
                return dateFormatter.date(from: dateString) ?? Date()
            }
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromDate = try safelyDecodeDate(for: .fromDate, in: container)
        fromTime = try container.decode(String.self, forKey: .fromTime)
        toDate = try safelyDecodeDate(for: .toDate, in: container)
        toTime = try container.decode(String.self, forKey: .toTime)
        isSunset = try container.decode(Bool.self, forKey: .isSunset)

        do {
            statusCode = try container.decode(Int.self, forKey: .statusCode)
        } catch {
            let stringValue = try container.decode(String.self, forKey: .statusCode)
            statusCode = Int(stringValue) ?? -1
        }

        statusString = try container.decode(String.self, forKey: .statusString)
        isChanged = try container.decode(Bool.self, forKey: .isChanged)
    }
}
