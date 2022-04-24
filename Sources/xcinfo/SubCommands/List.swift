//
//  Copyright © 2019 xcodereleases.com
//  MIT license - see LICENSE.md
//

import ArgumentParser
import xcinfoCore
import Rainbow

extension Core.ListFilter: EnumerableFlag {}

extension XCInfo {
    struct List: AsyncParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "List all available Xcode versions",
            discussion: "List all available Xcode versions available according to xcodereleases.com."
        )

        @OptionGroup()
        var globals: DefaultOptions

        @Flag
        var listFilter: Core.ListFilter?

        @Flag(
            name: [.customLong("all"), .customShort("a")],
            help: "Shows all Xcode version ever released. If false or omitted, only installable versions of the last year are printed."
        )
        var showAllVersions = false

        @OptionGroup
        var listOptions: ListOptions

        func run() async throws {
            Rainbow.enabled = globals.useANSI
            let core = Core(environment: .live(isVerboseLoggingEnabled: globals.isVerbose))
            try await core.list(shouldUpdate: listOptions.updateList, showAllVersions: showAllVersions, filter: listFilter)
        }
    }
}
