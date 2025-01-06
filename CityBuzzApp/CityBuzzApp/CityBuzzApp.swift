//
//  CityBuzzAppApp.swift
//  CityBuzzApp
//
//  Created by Brent Sanford on 1/2/25.
//

import SwiftUI

@main
struct CityBuzzApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .background(Color.black.ignoresSafeArea())
        }
    }
}
