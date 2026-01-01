// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Paste",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "Paste",
            dependencies: [],
            path: "Sources",
            sources: ["."]
        )
    ]
)
