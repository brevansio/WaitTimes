//
//  ImageDataModel.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/21.
//

import Foundation
import Combine
import SwiftSoup

private extension Location {
    var imageSourceURL: URL {
        switch self {
        case .land:
            return URL(string: "https://www.tokyodisneyresort.jp/tdl/realtime/attraction/")!
        case .sea:
            return URL(string: "https://www.tokyodisneyresort.jp/tds/realtime/attraction/")!
        }
    }
}

class ImageDataModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var imageData: [ImageDataSource] = []

    func loadImages(for location: Location) {
        URLSession.shared
            .dataTaskPublisher(for: location.imageSourceURL)
            .retry(2)
            .map(\.data)
            .map { data -> ImageDataWrapper? in
                do {
                    let html = String(data: data, encoding: .utf8)!
                    let document = try SwiftSoup.parse(html)
                    let scriptElement = try document.select("script").first(where: { element in
                        try element.html().contains("var facilities")
                    })

                    guard let javaScriptString = try scriptElement?.html(),
                          let startIndex = javaScriptString.firstIndex(of: "{"),
                          let endIndex = javaScriptString.firstIndex(of: ";") else {
                        return nil
                    }
                    let jsonString = String(javaScriptString[startIndex..<endIndex])
                    let jsonData = jsonString.data(using: .utf8)!
                    return try JSONDecoder().decode(ImageDataWrapper.self, from: jsonData)
                } catch {
                    return nil
                }
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // TODO: Something with the error
                    print(error)
                }
            }, receiveValue: { dataWrapper in
                DispatchQueue.main.async {
                    self.imageData = dataWrapper?.results ?? []
                }
            })
            .store(in: &cancellables)
    }
}
