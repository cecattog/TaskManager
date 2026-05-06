//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 5/5/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class TaskListViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func loadTasks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "No user logged in"
            return
        }
        
        isLoading = true
        
        listener = db.collection("tasks")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self.tasks = documents.compactMap { document in
                    try? document.data(as: Task.self)
                }
            }
    }
    
    func addTask(title: String) {
        guard let userId = Auth.auth().currentUser?.uid,
              !title.isEmpty else { return }
        
        let task = Task(title: title, userId: userId)
        
        do {
            try db.collection("tasks").addDocument(from: task)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleTask(_ task: Task) {
        guard let id = task.id else { return }
        
        let updatedTask = Task(
                    id: id,
                    title: task.title,
                    userId: task.userId,
                    createdAt: task.createdAt,
                    isCompleted: !task.isCompleted
                )
        
        do {
            try db.collection("tasks").document(id).setData(from: updatedTask)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func cleanup() {
        listener?.remove()
    }
    
    func deleteTask(task: Task) {
        guard let id = task.id else { return }
        
        db.collection( "tasks" ).document( id ).delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document deleted")
            }
        }
        
        
        
    }
    
}
