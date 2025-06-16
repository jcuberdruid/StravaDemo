//
//  StravaDemoApp.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//

import SwiftUI

@main
struct StravaDemoApp: App {
    @State var deps = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .environment(deps)
        }
    }
}
