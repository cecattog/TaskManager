//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 4/5/26.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct TaskManagerApp: App {
    @StateObject private var appState = AppState()
    
    init() {
        FirebaseApp.configure()
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TaskListView()
            } else {
                LoginView()
            }
        }
    }
}

