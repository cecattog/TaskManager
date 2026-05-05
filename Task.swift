//
//  Task.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 5/5/26.
//


import Foundation
import FirebaseFirestore

struct Task: Codable, Identifiable {
    
    @DocumentID var id: String?
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var userId: String
    
init(title: String, isCompleted: Bool = false, userId: String) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = Date()
        self.userId = userId
    }
    
    
    init(id: String, title: String, userId: String, createdAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.userId = userId
        self.isCompleted = isCompleted
        
    }
    
    
    

}
