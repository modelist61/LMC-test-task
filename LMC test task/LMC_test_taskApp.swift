//
//  LMC_test_taskApp.swift
//  LMC test task
//
//  Created by Dmitry Tokarev on 02.10.2021.
//

import SwiftUI

@main
struct LMC_test_taskApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
        }
    }
}
