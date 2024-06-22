//
//  iTuneApiManager.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import Foundation

public struct iTuneApiManager {
    static func getAppInformation(appID: String) async throws -> iTuneResponse {
        
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        
        guard let url = URL(string: urlString) else {
            throw UpstreamButton.iTuneApiFailure.wrongURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw UpstreamButton.iTuneApiFailure.timeOut
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(iTuneResponse.self, from: data)
            return decodedData
        } catch {
            throw UpstreamButton.iTuneApiFailure.dataNotFound
        }
    }
}
