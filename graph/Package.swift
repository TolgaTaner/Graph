// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "graph",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "graph",
            targets: ["graph"]),
    ],
    targets: [
        .target(name: "graph",
                resources: [.process("graph.json")]),
        .testTarget(
            name: "graphTests",
            dependencies: ["graph"]
        ),
    ]
)
