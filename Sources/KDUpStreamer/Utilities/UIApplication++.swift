//
//  UIApplication++.swift
//  KDUpStreamer
//
//  Created by KavinduDissanayake on 2024-06-22.
//  All rights reserved for KDmobileApps.
//

import UIKit

extension UIApplication {
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Not Found"
    }
}
