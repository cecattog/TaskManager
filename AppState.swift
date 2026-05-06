//
//  AppState.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 6/5/26.
//
import SwiftUI
import FirebaseAuth

@MainActor
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isLoggedIn = (user != nil)
        }
    }
}
