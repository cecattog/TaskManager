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
    
    @State private var isLoggedIn = false
    
    init() {
        FirebaseApp.configure()
        print("✅Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                TaskListView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
            
        }
    }
}

