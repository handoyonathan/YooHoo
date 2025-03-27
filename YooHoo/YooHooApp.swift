//
//  YooHooApp.swift
//  YooHoo
//
//  Created by Yonathan Handoyo on 24/03/25.
//

import SwiftUI
import SwiftData

@main
struct YooHooApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView() // Pakai TabView sebagai root view
            
        }.modelContainer(for: [Buddy.self])
    }
}
