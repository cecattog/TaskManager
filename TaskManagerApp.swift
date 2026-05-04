//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 4/5/26.
//

import SwiftUI
import FirebaseCore

@main
struct TaskManagerApp: App {
    
    init() {
        FirebaseApp.configure()
        print("✅Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            FirestoreTestView()
        }
    }
}
