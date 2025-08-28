// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let checksumForShield = "28ed6c3a69c62e19fc508176cc4401e6e282a941b0110dfed85b528e39e4a4c3"
let checksumForFP = "cdceb6f13d2302bfdbf95f26d013264c678058ffbf1226034aaa0be1763d796b"
let checksumForIDWiseNFC = "81a52e35d46850a61d780a6e203ce53c8731191e3a7384419059b3c77b095933"

let shieldVersion = "1-5-50"
let fpVersion = "2.7.0"
let idwiseNFCSDKVersion = "5.6.2"

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
