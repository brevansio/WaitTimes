//
//  Facility.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import Foundation

final class Facility: Codable, Identifiable {
    let code: Int
    let name: String
    let kana: String
    let isNew: Bool
    let urlString: String?
    let statusCode: Int?
    let status: String?
    let standByTime: Int
    let openDate: Date?
    let openTime: String?
    let closeDate: Date?
    let closeTime: String?
    let operatingStatusCode: Int?
    let operatingStatus: String?
    let isSunset: Bool?
    let hasFastPass: Bool
    let fastPassStatusFlag: Bool?
    let fastPassStatus: String?
    let fastPassStatusCode: Int?
    let fastPassOpenDate: Date?
    let fastPassOpenTime: String?
    let fastPassCloseDate: Date?
    let fastPassCloseTime: String?
    let hasUseLimit: Bool
    let showStandbyTime: Bool
    let hasOperatingChanges: Bool
    let updateTime: String
    let operatingHours: [OperatingHours]?

    enum CodingKeys: String, CodingKey {
        case code = "FacilityID"
        case name = "FacilityName"
        case kana = "FacilityKanaName"
        case isNew = "NewFlg"
        case urlString = "FacilityURLSP"
        case statusCode = "FacilityStatusCD"
        case status = "FacilityStatus"
        case standByTime = "StandbyTime"
        case openDate = "OperatingHoursFromDate"
        case openTime = "OperatingHoursFrom"
        case closeDate = "OperatingHoursToDate"
        case closeTime = "OperatingHoursTo"
        case operatingStatusCode = "OperatingStatusCD"
        case operatingStatus = "OperatingStatus"
        case isSunset = "SunsetFlg"
        case hasFastPass = "Fsflg"
        case fastPassStatusFlag = "FsStatusflg"
        case fastPassStatus = "FsStatus"
        case fastPassStatusCode = "FsStatusCD"
        case fastPassOpenDate = "FsStatusStartDate"
        case fastPassOpenTime = "FsStatusStartTime"
        case fastPassCloseDate = "FsStatusEndDate"
        case fastPassCloseTime = "FsStatusEndTime"
        case hasUseLimit = "UseLimitFlg"
        case showStandbyTime = "UseStandbyTimeStyle"
        case hasOperatingChanges = "OperatingChgFlg"
        case updateTime = "UpdateTime"
        case operatingHours = "operatingHours"
    }

    init(from decoder: Decoder) throws {
        func safelyDecodeInt(for key: CodingKeys, in container: KeyedDecodingContainer<Facility.CodingKeys>) throws -> Int {
            do {
                return try container.decode(Int.self, forKey: key)
            } catch {
                let stringValue = try container.decode(String.self, forKey: key)
                return Int(stringValue) ?? -1
            }
        }

        func safelyDecodeDate(for key: CodingKeys, in container: KeyedDecodingContainer<Facility.CodingKeys>) throws -> Date {
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

        code = try safelyDecodeInt(for: .code, in: container)
        name = try container.decode(String.self, forKey: .name)
        kana = try container.decode(String.self, forKey: .kana)
        isNew = try container.decode(Bool.self, forKey: .isNew)
        urlString = try? container.decode(String.self, forKey: .urlString)
        statusCode = try? safelyDecodeInt(for: .statusCode, in: container)
        status = try? container.decode(String.self, forKey: .status)

        do {
            standByTime = try safelyDecodeInt(for: .standByTime, in: container)
        } catch {
            standByTime = -1
        }

        openDate = try? safelyDecodeDate(for: .openDate, in: container)
        openTime = try? container.decode(String.self, forKey: CodingKeys.openTime)
        closeDate = try? safelyDecodeDate(for: .closeDate, in: container)
        closeTime = try? container.decode(String.self, forKey: CodingKeys.closeTime)
        operatingStatusCode = try? safelyDecodeInt(for: .operatingStatusCode, in: container)
        operatingStatus = try? container.decode(String.self, forKey: .operatingStatus)
        isSunset = try? container.decode(Bool.self, forKey: .isSunset)
        hasFastPass = try container.decode(Bool.self, forKey: .hasFastPass)
        fastPassStatusFlag = try? container.decode(Bool.self, forKey: .fastPassStatusFlag)
        fastPassStatus = try? container.decode(String.self, forKey: .fastPassStatus)
        fastPassStatusCode = try? safelyDecodeInt(for: .fastPassStatusCode, in: container)
        fastPassOpenDate = try? safelyDecodeDate(for: .fastPassOpenDate, in: container)
        fastPassOpenTime = try? container.decode(String.self, forKey: .fastPassOpenTime)
        fastPassCloseDate = try? safelyDecodeDate(for: .fastPassCloseDate, in: container)
        fastPassCloseTime = try? container.decode(String.self, forKey: .fastPassCloseTime)
        hasUseLimit = try container.decode(Bool.self, forKey: .hasUseLimit)
        showStandbyTime = try container.decode(Bool.self, forKey: .showStandbyTime)
        hasOperatingChanges = try container.decode(Bool.self, forKey: .hasOperatingChanges)
        updateTime = try container.decode(String.self, forKey: .updateTime)
        operatingHours = try? container.decode([OperatingHours].self, forKey: .operatingHours)
    }
}
