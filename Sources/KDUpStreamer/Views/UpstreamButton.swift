//
//  UpstreamButton.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import SwiftUI
import Combine

public class UpstreamButton {
    
    public class Upstream: ObservableObject {
        
        @Published public var data: ResultResponse = .init()
        @Published public var showUpstreamView: Bool = false
        @Published public var updateStatus: UpdateStatus = .updateNotAvailable
        
        public init(appId: String) {
            Task {
                await fetchStatus(appID: appId)
            }
        }
        
        public func fetchStatus(appID: String) async {
            do {
                let data = try await iTuneApiManager.getAppInformation(appID: appID)
                if let firstResult = data.results.first, await firstResult.version != UIApplication.appVersion {
                    DispatchQueue.main.async {
                        self.updateStatus = .updateAvailable
                        self.data = firstResult
                    }
                }
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    public enum UpdateStatus {
        case updateAvailable
        case updateNotAvailable
    }
    
    public enum iTuneApiFailure: Error, LocalizedError {
        case dataNotFound
        case wrongURL
        case timeOut
        case unknownError
        
        public var errorDescription: String? {
            switch self {
            case .dataNotFound:
                return "Data not found."
            case .wrongURL:
                return "The URL is incorrect."
            case .timeOut:
                return "The request timed out."
            case .unknownError:
                return "An unknown error occurred."
            }
        }
    }
}
