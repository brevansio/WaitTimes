//
//  ImageDataSource.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/21.
//

import Foundation

struct ImageDataWrapper: Codable {
    var results: [ImageDataSource]?
    var totalCount: Int?
}

struct ImageDataSource: Codable {
    let name: String?
    let thumbnailURL: String?
    let detailURL: String?

    // TODO: If any of the other stuff is needed, it can be added

    enum CodingKeys: String, CodingKey {
        case name
        case thumbnailURL = "thum_name"
        case detailURL = "detail_url"
    }
}
