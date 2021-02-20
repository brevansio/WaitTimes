//
//  FacilityDataModel.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import Foundation
import Combine

class FacilityDataModel: ObservableObject {
    enum Location {
        case land
        case sea

        var url: URL {
            switch self {
            case .land:
                return URL(string: "https://www.tokyodisneyresort.jp/_/realtime/tdl_attraction.json")!
            case .sea:
                return URL(string: "https://www.tokyodisneyresort.jp/_/realtime/tds_attraction.json")!
            }
        }
    }

    enum State {
        case idle
        case loading
        case loaded([Facility])
        case failure(Error)
    }

    @Published private(set) var state: State = .idle

    var location: Location
    private var cancellables = Set<AnyCancellable>()

    init(location: Location) {
        self.location = location
    }

    func load() {
        state = .loading
        URLSession.shared
            .dataTaskPublisher(for: location.url)
            .retry(2)
            .map(\.data)
            .decode(type: [Facility].self, decoder: JSONDecoder())
            .sink { (completion) in
                if case let .failure(error) = completion {
                    DispatchQueue.main.async {
                        self.state = .failure(error)
                    }
                }
            } receiveValue: { facilities in
                DispatchQueue.main.async {
                    self.state = .loaded(facilities)
                }
            }
            .store(in: &cancellables)
    }

}