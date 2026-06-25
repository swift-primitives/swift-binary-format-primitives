// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-binary-format-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Binary Format Primitives",
            targets: ["Binary Format Primitives"]
        ),
        .library(
            name: "Binary Format Primitives Standard Library Integration",
            targets: ["Binary Format Primitives Standard Library Integration"]
        ),
        .library(
            name: "Binary Format Primitives Test Support",
            targets: ["Binary Format Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-binary-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-format-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Binary Format Primitives",
            dependencies: [
                .product(name: "Binary Primitive", package: "swift-binary-primitives"),
                .product(name: "Format Primitives", package: "swift-format-primitives"),
            ]
        ),
        .target(
            name: "Binary Format Primitives Standard Library Integration",
            dependencies: [
                "Binary Format Primitives",
            ]
        ),
        .target(
            name: "Binary Format Primitives Test Support",
            dependencies: [
                "Binary Format Primitives",
                .product(name: "Binary Primitives Test Support", package: "swift-binary-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Binary Format Primitives Tests",
            dependencies: [
                "Binary Format Primitives",
                "Binary Format Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
