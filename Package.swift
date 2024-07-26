// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KeySender",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "KeySender",
            targets: ["KeySender"]
        ),
    ],
    targets: [
        .target(
            name: "KeySender"
        ),
        .testTarget(
            name: "KeySenderTests",
            dependencies: ["KeySender"]
        ),
    ]
)
