//
//  CalculateDistanceApp.swift
//  CalculateDistance
//
//  Created by Angelos Staboulis on 17/4/24.
//

import SwiftUI

@main
struct CalculateDistanceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(destinationCoordinates: .init(), currentCoordinates: .init(), destination: "", current: "", distance: "", realDistance: "")
        }
    }
}
