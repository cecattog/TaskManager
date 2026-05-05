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
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    
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
                login()
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            
            Text(errorMessage)
                .foregroundColor(.red)
            
            Button("Sign Up") {
                signUp()
                
            }
            .font(.caption)
            .foregroundStyle(.gray)
            
        }
        .padding()
        
    }
    
    
    func login() {
        
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter your email and password to login."
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    func signUp() {
        //Check for empty fields
        
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields."
            return
        }
        
        //Call FireBase
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
    
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}

