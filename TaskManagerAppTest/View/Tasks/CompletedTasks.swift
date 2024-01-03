//
//  CompletedTasks.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 6.01.2024.
//

import SwiftUI

struct CompletedTasks: View {
    @StateObject var taskManager: TaskManager // State object for managing the task manager
    
    var body: some View {
        // Vertical scroll view containing the list of completed tasks
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Check if there are no tasks, display a message and an image
                if taskManager.tasks.isEmpty {
                    VStack {
                        Text("No tasks added yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                        Image(systemName: "xmark.bin")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                } else {
                    // Display the list of completed tasks using LazyVStack
                    LazyVStack(spacing: 10) {
                        ForEach(taskManager.tasks.filter { $0.isDone }) { task in
                            // Display each completed task using TaskCard
                            TaskCard(task: task, taskManager: TaskManager())
                        }
                        .padding(5)
                    }
                }
            }
            .padding(5)
        }
        .onAppear(perform: taskManager.fetchTasks) // Fetch tasks when the view appears
    }
}
