//
//  ResultResponse.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import Foundation

public struct ResultResponse: Codable {
    public var releaseNotes: String = ""
    public var description: String = ""
    public var version: String = ""
    public var trackViewUrl: String = ""
}
