//
//  TaskListView.swift
//  TaskManager
//
//  Created by Guilherme Serpa Cecatto on 4/5/26.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Add task row
                HStack {
                    TextField("New task...", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
                .padding()
                
                // Loading state
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading tasks...")
                    Spacer()
                }
                // Task list
                else if viewModel.tasks.isEmpty {
                    Spacer()
                    Text("No tasks yet. Add one above!")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.toggleTask(task)
                                }
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                        }
                    }
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                Button("Sign Out") {
                    viewModel.signOut()
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.loadTasks()
            }
            .onDisappear {
                viewModel.cleanup()
            }
        }
    }
}
