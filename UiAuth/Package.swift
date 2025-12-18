// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UiAuth",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UiAuth",
            targets: ["UiAuth"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        .package(url: "https://github.com/KvColorPalette/KvColorPalette-iOS.git", from: "2.0.1"),
        .package(path: "../LibParent"),
        .package(path: "../LibCommonData"),
        .package(path: "../LibCommonUi"),
        .package(path: "../LibNetwork")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UiAuth",
            dependencies: [
                "Factory",
                "KvColorPalette-iOS",
                "LibParent",
                "LibCommonData",
                "LibCommonUi",
                "LibNetwork"
            ]
        ),

    ]
)
