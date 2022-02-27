// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "Activity",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(
            name: "ActivityComposition",
            targets: [
                "ActivityComposition"
            ]
        ),
        .library(
            name: "ActivityRIB",
            targets: [
                "ActivityRIB"
            ]
        )
    ],
    dependencies: [
        .package(name: "Analytics", url: "https://github.com/kutchie-pelaez-packages/Analytics.git", .branch("master")),
        .package(name: "Core", url: "https://github.com/kutchie-pelaez-packages/Core.git", .branch("master")),
        .package(name: "CoreRIB", url: "https://github.com/kutchie-pelaez-packages/CoreRIB.git", .branch("master")),
        .package(name: "CoreUI", url: "https://github.com/kutchie-pelaez-packages/CoreUI.git", .branch("master")),
        .package(name: "Logging", url: "https://github.com/kutchie-pelaez-packages/Logging.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "ActivityComposition",
            dependencies: [
                .product(name: "AnalyticsTracker", package: "Analytics"),
                .product(name: "CoreRIB", package: "CoreRIB"),
                .product(name: "Logger", package: "Logging"),
                .target(name: "ActivityRIB")
            ]
        ),
        .target(
            name: "ActivityRIB",
            dependencies: [
                .product(name: "AnalyticsEvent", package: "Analytics"),
                .product(name: "AnalyticsTracker", package: "Analytics"),
                .product(name: "Core", package: "Core"),
                .product(name: "CoreRIB", package: "CoreRIB"),
                .product(name: "CoreUI", package: "CoreUI"),
                .product(name: "Logger", package: "Logging"),
                .product(name: "RouterIdentifier", package: "CoreRIB")
            ]
        )
    ]
)
