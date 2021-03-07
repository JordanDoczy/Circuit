//
//  CircuitApp.swift
//  Circuit
//
//  Created by Jordan Doczy on 3/6/21.
//

import SwiftUI

@main
struct CircuitApp: App {

    
    @StateObject private var model = Model()

    
    var body: some Scene {
        WindowGroup {
            ToggleButtonGrid()
                .environmentObject(model)
        }
    }
}
