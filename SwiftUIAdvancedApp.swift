//
//  SwiftUIAdvancedApp.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/1/21.
//

import SwiftUI

@main
struct SwiftUIAdvancedApp: App {
    
    let currentUserSignedIn: Bool
    
    init() {
        
//        let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_StartSignedIn") ? true : false
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_StartSignedIn") ? true : false
//        let value = ProcessInfo.processInfo.environment["-UITest_StartSignedIn2"]
//        let userIsSignedIn: Bool = value == "true" ? true : false
        self.currentUserSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
//            CloudKitCrudBootcamp()
            CloudKitUserBootcamp()
//            UITestingBootcampView(currentUserIsSignedIn: currentUserSignedIn)
        }
    }
}
