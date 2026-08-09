//
//  Version.swift
//  ScryfallSwift
//

import Foundation


/// Version of this library.
///
/// SwiftPM offers no way to read a package's own version at runtime, so this is
/// maintained by hand. It must be kept in sync with `MARKETING_VERSION` in
/// `ScryfallSwift.xcodeproj/project.pbxproj` — `VersionTests` fails the build if it drifts.
public enum ScryfallSwiftVersion {
    public static let current = "0.13.10"
}
