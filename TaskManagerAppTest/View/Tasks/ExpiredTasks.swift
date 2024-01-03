//
//  ExpiredTasks.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 6.01.2024.
//

import SwiftUI

// Extension on Date to check if the date is in the past (isPast)
extension Date {
    var isPast: Bool {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let taskDate = calendar.startOfDay(for: self)

        return taskDate < currentDate
    }
}

// SwiftUI view struct representing a list of expired tasks
struct ExpiredTasks: View {
    @StateObject var taskManager: TaskManager // State object for managing the task manager
    var expiredTasks: [Task] {
        return taskManager.tasks.filter { !$0.isDone && $0.deadline.isPast } // Filter tasks based on completion status and whether they are past due
    }

    var body: some View {
        // Vertical scroll view containing the list of expired tasks
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
                    // Display the list of expired tasks using LazyVStack
                    LazyVStack(spacing: 10) {
                        ForEach(expiredTasks) { task in
                            // Display each expired task using ExpiredTaskCard
                            ExpiredTaskCard(task: task, taskManager: TaskManager())
                        }
                        .padding(5)
                    }
                }
            }
            .padding(5)
            .navigationTitle("Task Manager") // Set navigation title
            .onAppear(perform: taskManager.fetchTasks) // Fetch tasks when the view appears
        }
    }
}
