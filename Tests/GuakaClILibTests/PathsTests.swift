//
//  PathsTests.swift
//  guaka-cli
//
//  Created by Omar Abdelhafith on 27/11/2016.
//
//

import XCTest
@testable import GuakaClILib

class PathsTests: XCTestCase {

  override func setUp() {
    super.setUp()
    MockDirectoryType.clear()
    MockFileType.clear()
  }

  func testGenerateSourcePathExample() {
    let p = Paths(rootDirectory: "root")
    XCTAssertEqual(p.rootDirectory, "root")
    XCTAssertEqual(p.sourcesDirectoryPath, "root/Sources")
    XCTAssertEqual(p.mainTargetDirectoryPath, "root/Sources/root")
  }

  func testGetsPackagesFile() {
    let p = Paths(rootDirectory: "root")
    XCTAssertEqual(p.packagesFile, "root/Package.swift")
  }

  func testGetsMainSwiftFile() {
    let p = Paths(rootDirectory: "root")
    XCTAssertEqual(p.mainSwiftFile, "root/Sources/root/main.swift")
  }

  func testGetsSetupSwiftFile() {
    let p = Paths(rootDirectory: "root")
    XCTAssertEqual(p.setupSwiftFile, "root/Sources/root/setup.swift")
  }

  func testGetsPathForSwiftFile() {
    let p = Paths(rootDirectory: "root")
    XCTAssertEqual(p.path(forSwiftFile: "abc"), "root/Sources/root/abc.swift")
  }

  func testGetsProjectName() {
    let p = Paths(rootDirectory: "/root/abcd/ef")
    XCTAssertEqual(p.projectName, "ef")
  }

  func testReturnCurrentPaths() {
    MockDirectoryType.currentDirectory = "/root"

    GuakaCliConfig.dir = MockDirectoryType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.rootDirectory, "/root")
  }

  func testItChecksIfCurrentIsGuaka() {
    MockDirectoryType.currentDirectory = "/root"
    MockFileType.fileExistanceValue = [
      "/root/Sources/root": true,
      "/root/Package.swift": true,
      "/root/Sources/root/main.swift": true,
      "/root/Sources/root/setup.swift": true,
    ]

    GuakaCliConfig.dir = MockDirectoryType.self
    GuakaCliConfig.file = MockFileType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.isGuakaDirectory, true)
  }

  func testReturnFalseForGuakaIfSourcesNotThere() {
    MockDirectoryType.currentDirectory = "/root"
    MockFileType.fileExistanceValue = [
      "/root/Sources": false,
      "/root/Package.swift": true,
      "/root/Sources/root/main.swift": true,
      "/root/Sources/root/setup.swift": true,
    ]

    GuakaCliConfig.dir = MockDirectoryType.self
    GuakaCliConfig.file = MockFileType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.isGuakaDirectory, false)
  }

  func testReturnFalseForGuakaIfPackageNotThere() {
    MockDirectoryType.currentDirectory = "/root"
    MockFileType.fileExistanceValue = [
      "/root/Sources": true,
      "/root/Package.swift": false,
      "/root/Sources/root/main.swift": true,
      "/root/Sources/root/setup.swift": true,
    ]

    GuakaCliConfig.dir = MockDirectoryType.self
    GuakaCliConfig.file = MockFileType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.isGuakaDirectory, false)
  }

  func testReturnFalseForGuakaIfSetupNotThere() {
    MockDirectoryType.currentDirectory = "/root"
    MockFileType.fileExistanceValue = [
      "/root/Sources": true,
      "/root/Package.swift": true,
      "/root/Sources/root/main.swift": true,
      "/root/Sources/root/setup.swift": false,
    ]

    GuakaCliConfig.dir = MockDirectoryType.self
    GuakaCliConfig.file = MockFileType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.isGuakaDirectory, false)
  }

  func testReturnFalseForGuakaIfMainNotThere() {
    MockDirectoryType.currentDirectory = "/root"
    MockFileType.fileExistanceValue = [
      "/root/Sources": true,
      "/root/Package.swift": true,
      "/root/Sources/root/main.swift": false,
      "/root/Sources/root/setup.swift": true,
    ]

    GuakaCliConfig.dir = MockDirectoryType.self
    GuakaCliConfig.file = MockFileType.self

    let p = Paths.currentPaths
    XCTAssertEqual(p.isGuakaDirectory, false)
  }

  static let allTests = [
    ("testGenerateSourcePathExample", testGenerateSourcePathExample),
    ("testGetsPackagesFile", testGetsPackagesFile),
    ("testGetsMainSwiftFile", testGetsMainSwiftFile),
    ("testGetsSetupSwiftFile", testGetsSetupSwiftFile),
    ("testGetsPathForSwiftFile", testGetsPathForSwiftFile),
    ("testGetsProjectName", testGetsProjectName),
    ("testReturnCurrentPaths", testReturnCurrentPaths),
    ("testItChecksIfCurrentIsGuaka", testItChecksIfCurrentIsGuaka),
    ("testReturnFalseForGuakaIfSourcesNotThere", testReturnFalseForGuakaIfSourcesNotThere),
    ("testReturnFalseForGuakaIfPackageNotThere", testReturnFalseForGuakaIfPackageNotThere),
    ("testReturnFalseForGuakaIfSetupNotThere", testReturnFalseForGuakaIfSetupNotThere),
    ("testReturnFalseForGuakaIfMainNotThere", testReturnFalseForGuakaIfMainNotThere),
  ]
}
