//
//  KDUpStreamerTests.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import XCTest
@testable import KDUpStreamer

final class KDUpStreamerTests: XCTestCase {
    func testFetchStatus() async {
        let upstream = UpstreamButton.Upstream(appId: "123456")
        await upstream.fetchStatus(appID: "123456")
        // Write your assertions here
    }
}
