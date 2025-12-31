// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UiSplash",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UiSplash",
            targets: ["UiSplash"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.5.3"),
        .package(url: "https://github.com/KvColorPalette/KvColorPalette-iOS.git", from: "2.1.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.29.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.1.0"),
        .package(path: "../LibParent"),
        .package(path: "../LibCommonData"),
        .package(path: "../LibCommonUi"),
        .package(path: "../LibNetwork")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UiSplash",
            dependencies: [
                "Factory",
                "KvColorPalette-iOS",
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                "LibParent",
                "LibCommonData",
                "LibCommonUi",
                "LibNetwork"
            ]
        ),

    ]
)
