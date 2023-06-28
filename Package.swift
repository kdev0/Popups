// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Popups",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Popups",
            targets: ["Popups"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Popups",
            dependencies: []),
        .testTarget(
            name: "PopupsTests",
            dependencies: ["Popups"]),
    ]
)
