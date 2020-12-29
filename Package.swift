// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Neolith-Routes",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "Neolith-Routes",
      targets: ["Neolith-Routes"]),
  ],
  dependencies: [
    .package(url: "https://github.com/jemmons/Neolith.git", from: "0.0.1"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(name: "Neolith-Routes", dependencies: [
      .byName(name: "Neolith")
    ]),
    .testTarget(
      name: "Neolith-RoutesTests",
      dependencies: ["Neolith-Routes"]),
  ]
)
