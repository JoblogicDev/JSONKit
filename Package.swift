// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JoblogicJSONKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "JoblogicJSONKit",
            targets: ["JoblogicJSONKit"]
        ),
    ],
    targets: [
        .target(
            name: "JoblogicJSONKit",
            path: "Sources/JSONKit",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("REACHABILITY_USE_SYSTEMCONFIGURATION", to: "1")
            ]
        ),
    ]
)
