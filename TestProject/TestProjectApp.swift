//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

@main
struct TestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
