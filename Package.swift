// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let llamaVersion = "b8816"
// Custom xcframework built by .github/workflows/build-xcframework.yml with
// LLAMA_BUILD_TOOLS=ON so libmtmd.a ships inside llama.framework alongside
// libllama/libggml. This gives us the multimodal (clip + mtmd) APIs needed
// for Gemma 4 vision input, which the stock ggml-org release strips out.
let llamaChecksum = "683a07447eac381c0b11605b0ce76e792051306bd55c64a104284377782dcfd6"

let package = Package(
    name: "swift-llama-cpp",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftLlama",
            targets: ["SwiftLlama"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftLlama",
            dependencies: [
                "llama"
            ]
        ),
        .binaryTarget(
            name: "llama",
            url: "https://github.com/Keep-DS/swift-llama-cpp/releases/download/\(llamaVersion)-mtmd/llama-\(llamaVersion)-mtmd-xcframework.zip",
            checksum: llamaChecksum
        ),
        .testTarget(
            name: "SwiftLlamaTests",
            dependencies: ["SwiftLlama"],
            resources: [.copy("Resources")]
        ),
    ]
)
