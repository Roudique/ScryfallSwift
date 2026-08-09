//
//  VersionTests.swift
//  ScryfallSwiftTests
//

import Foundation
import XCTest
@testable import ScryfallSwift


class VersionTests: XCTestCase {
    /// `ScryfallSwiftVersion.current` is hand-maintained, so a version bump that touches only
    /// the Xcode project would silently leave the User-Agent reporting a stale version.
    func testVersionMatchesXcodeProject() throws {
        let repoRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()   // ScryfallSwiftTests
            .deletingLastPathComponent()   // Tests
            .deletingLastPathComponent()   // repo root
        let pbxprojURL = repoRoot
            .appendingPathComponent("ScryfallSwift.xcodeproj")
            .appendingPathComponent("project.pbxproj")

        let pbxproj = try String(contentsOf: pbxprojURL, encoding: .utf8)

        let regex = try NSRegularExpression(pattern: "MARKETING_VERSION = ([^;]+);")
        let matches = regex.matches(in: pbxproj,
                                    range: NSRange(pbxproj.startIndex..., in: pbxproj))
        let versions = Set(matches.compactMap { match -> String? in
            guard let range = Range(match.range(at: 1), in: pbxproj) else { return nil }
            return String(pbxproj[range]).trimmingCharacters(in: .whitespaces)
        })

        XCTAssertFalse(versions.isEmpty, "No MARKETING_VERSION found in project.pbxproj.")
        XCTAssertEqual(versions.count, 1,
                       "Build configurations disagree on MARKETING_VERSION: \(versions.sorted()).")
        XCTAssertEqual(versions.first, ScryfallSwiftVersion.current,
                       "ScryfallSwiftVersion.current is stale. Update Sources/ScryfallSwift/Version.swift to match MARKETING_VERSION.")
    }
}
