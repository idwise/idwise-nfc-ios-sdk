// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let checksumForShield = "3f80bef16ebda425b53a8e9f2e7d4a3ce9b027d8dbcccd057605acca8c3bef83"
let checksumForFP = "6c09a037218dc8ac10233d334de4dcdc4832fbf5f057c60ee8932d30d551190f"
let checksumForIDWiseNFC = "814c4b2682a14c4126dd5c55b00f0a8fd5a6e9681a626eec4b3e92e8c94aee5f"

let shieldVersion = "1-5-52"
let fpVersion = "2.13.0"
let idwiseNFCSDKVersion = "6.4.0"

let package = Package(
    name: "IDWiseNFC",
    platforms: [
        .iOS(.v15)
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
       .package(url: "https://github.com/regulaforensics/DocumentReaderMRZRFID-Swift-Package.git", exact: "7.5.11018"),
       .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", exact: "3.3.1000")
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
                .product(name: "MRZRFID", package: "DocumentReaderMRZRFID-Swift-Package"),
                .product(name: "OpenSSL", package: "OpenSSL")
            ],
            path: "Sources/IDWiseNFCTarget"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
