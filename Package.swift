// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let checksumForFP = "cdceb6f13d2302bfdbf95f26d013264c678058ffbf1226034aaa0be1763d796b"
let checksumForIDWiseNFC = "7cc8221933006d2ab3896dcf23b9540c9fb862e01e41873e26f25e3ea0c5499c"

let fpVersion = "2.7.0"
let idwiseNFCSDKVersion = "5.4.5"

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
                .product(name: "DocumentReader", package: "DocumentReader-Swift-Package"),
                .product(name: "MRZRFID", package: "DocumentReaderMRZRFID-Swift-Package")
            ],
            path: "Sources/IDWiseNFCTarget"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
