// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "gameanalytics_sdk",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "gameanalytics-sdk", targets: ["gameanalytics_sdk"])
    ],
    dependencies: [
        .package(url: "https://github.com/GameAnalytics/GA-SDK-IOS.git", exact: "5.0.1")
    ],
    targets: [
        .target(
            name: "gameanalytics_sdk",
            dependencies: [
                .product(name: "GameAnalytics", package: "GA-SDK-IOS")
            ],
            cSettings: [
                .headerSearchPath("include/gameanalytics_sdk")
            ]
        )
    ]
)
