// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KDUpStreamer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "KDUpStreamer",
            targets: ["KDUpStreamer"]),
    ],
    targets: [
        .target(
            name: "KDUpStreamer",
            dependencies: []),
        .testTarget(
            name: "KDUpStreamerTests",
            dependencies: ["KDUpStreamer"]),
    ]
)
