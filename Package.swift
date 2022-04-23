// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcinfo",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "xcinfo",
            targets: ["xcinfo"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.0"),
        .package(url: "https://github.com/xcodereleases/data.git", branch: "master"),
        .package(url: "https://github.com/getGuaka/Prompt.git", from: "0.0.0"),
        .package(url: "https://github.com/getGuaka/Run.git", from: "0.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "XCIFoundation",
            dependencies: ["Rainbow"]
        ),
        .target(
            name: "XCUnxip",
            dependencies: []
        ),
        .executableTarget(
            name: "xcinfo",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "xcinfoCore",
                "Prompt",
                "Rainbow",
                "Run",
                "XCIFoundation",
            ],
            linkerSettings: [
                LinkerSetting.linkedFramework("PackageKit"),
                LinkerSetting.unsafeFlags(["-F/System/Library/PrivateFrameworks/"]),
            ]
        ),
        .target(
            name: "xcinfoCore",
            dependencies: [
                "OlympUs",
                "XCIFoundation",
                "XCUnxip",
                .product(name: "XCModel", package: "data"),
            ]
        ),
        .testTarget(
            name: "xcinfoCoreTests",
            dependencies: ["xcinfoCore", "Prompt", "Run", "XCUnxip"],
            linkerSettings: [
                LinkerSetting.linkedFramework("PackageKit"),
                LinkerSetting.unsafeFlags(["-F/System/Library/PrivateFrameworks/"]),
            ]
        ),
        .target(
            name: "OlympUs",
            dependencies: ["XCIFoundation", "Prompt"]
        ),
    ]
)
