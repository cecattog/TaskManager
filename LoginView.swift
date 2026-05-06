//
//  LoginView.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 4/5/26.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Task Manager")
                .font(.largeTitle)
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            
            Button("Login") {
                logIn()
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            
            Text(errorMessage)
                .foregroundColor(.red)
            
            if isLoading {
                ProgressView()
                    .padding()
            }
            
            Button("Sign Up") {
                signUp()
                
            }
            .font(.caption)
            .foregroundStyle(.gray)
            
        }
        .padding()
        
    }
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
            }
        }
        
        
    }
    
    
    
    func logIn() {
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Please enter your email and password"
                return
            }
            
            isLoading = true
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                }
            }
        
    
    
}
    
    
  
        
      
        
        
    }
    

    


