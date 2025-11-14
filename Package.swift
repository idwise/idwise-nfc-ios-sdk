// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let checksumForShield = "3f80bef16ebda425b53a8e9f2e7d4a3ce9b027d8dbcccd057605acca8c3bef83"
let checksumForFP = "cdceb6f13d2302bfdbf95f26d013264c678058ffbf1226034aaa0be1763d796b"
let checksumForIDWiseNFC = "38c71d72761114c8f916dd3b45357f57e3a3099bbbf5fd6eab8a6d03b8b06012"

let shieldVersion = "1-5-52"
let fpVersion = "2.7.0"
let idwiseNFCSDKVersion = "5.7.8"

let package = Package(
    name: "IDWiseNFC",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "IDWiseNFC",
            targets: ["IDWiseNFCTarget"]),
    ],
    dependencies: [
       // Adding external SPM dependencies
       .package(url: "https://github.com/regulaforensics/DocumentReader-Swift-Package.git", exact: "7.5.4221"),
       .package(url: "https://github.com/regulaforensics/DocumentReaderMRZRFID-Swift-Package.git", exact: "7.5.11018")
   ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "ShieldFraud",
            url: "https://s3.amazonaws.com/cashshield-sdk/shield-ptr-ios-swift-\(shieldVersion).zip",
            checksum: checksumForShield
        ),
        .binaryTarget(
            name: "FingerprintPro",
            url: "https://fpjs-public.s3.amazonaws.com/ios/\(fpVersion)/FingerprintPro-\(fpVersion)-\(checksumForFP).xcframework.zip",
            checksum: checksumForFP
        ),
        .binaryTarget(
            name: "IDWiseNFC",
            url: "https://mobile-sdk.idwise.ai/ios-sdk-nfc/\(idwiseNFCSDKVersion)/IDWiseNFC.xcframework.zip",
            checksum: checksumForIDWiseNFC
        ),
        
        // Wrapper Target to Link Dependencies
        .target(
            name: "IDWiseNFCTarget",
            dependencies: [
                "IDWiseNFC",         // Binary Target
                "FingerprintPro",    // Binary Target
                "ShieldFraud",
                .product(name: "DocumentReader", package: "DocumentReader-Swift-Package"),
                .product(name: "MRZRFID", package: "DocumentReaderMRZRFID-Swift-Package")
            ],
            path: "Sources/IDWiseNFCTarget"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
