// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwipeActions",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "SwipeActions",
            targets: ["SwipeActions"]
        ),
    ],
    targets: [
        .target(
            name: "SwipeActions",
            swiftSettings: [.swiftLanguageMode(.v6)]
        ),

    ]
)
