//
//  FireStoreTestView.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 4/5/26.
//

import SwiftUI
import FirebaseFirestore

struct FirestoreTestView: View {
    
    @State private var status: String = ""
    let db = Firestore.firestore()
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Fire Store Test")
            Text("\(status)")
            Button("Test Write") {
                status = "Writing..."
                db.collection("test").addDocument(data: ["message": "hello firestore", "timestamp": Date()]) { error in
                    
                    if let error = error {
                        self.status = "❌ Write failed: \(error.localizedDescription)"
                    } else {
                        self.status = "✅ Write successful! Check Firebase Console"
                    }
                    
                }
                
                
            }
            .buttonStyle(.borderedProminent)
            Button("Test Read") {
                status = "Reading..."
                db.collection( "test" ).getDocuments { snapshot, error in
                    
                    if let error = error {
                        self.status = "❌ Read failed: \(error.localizedDescription)"
                    } else {
                        let count = snapshot?.documents.count ?? 0
                        self.status = "✅ Read successful! Found \(count) documents"
                    }
                    
                }
                
                
            }
            .buttonStyle(.borderedProminent)
            
            
        }
    }
}
