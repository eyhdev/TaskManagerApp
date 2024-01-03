//
//  EditTaskView.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 4.01.2024.
//

import SwiftUI

struct EditTaskView: View {
    @StateObject private var taskManager: TaskManager
    var task: Task
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle: String
    @State private var taskDetails: String
    @State private var selectedColorIndex: Int
    @State private var selectedTaskTypeIndex: Int
    @State private var createdTime: String
    @State private var progress: Int
    @State private var taskDeadline: Date
    @State private var showDeleteAlert: Bool = false
    
    let colors = ["Red", "Green", "Blue", "Yellow", "Purple"] // Add more colors as needed
    let taskTypes = ["Basic", "Urgent", "Important"]

    init(taskManager: TaskManager, task: Task) {
        self._taskManager = StateObject(wrappedValue: taskManager)
        self.task = task
        self._taskTitle = State(initialValue: task.title)
        self._taskDetails = State(initialValue: task.details)
        self._selectedColorIndex = State(initialValue: colors.firstIndex(of: task.color.lowercased()) ?? 0)
        self._selectedTaskTypeIndex = State(initialValue: taskTypes.firstIndex(of: task.type) ?? 0)
        self._createdTime = State(initialValue: task.createdTime)
        self._progress = State(initialValue: task.progress)
        self._taskDeadline = State(initialValue: task.deadline)
    }

    var body: some View {
        Form {
            Section(header: Text("Task Information")) {
                TextField("Task Title", text: $taskTitle)
                TextField("Task Job Details", text: $taskDetails)

                Picker("Task Type", selection: $selectedTaskTypeIndex) {
                    ForEach(0..<taskTypes.count) {
                        Text(taskTypes[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Task Color")) {
                Picker("Select Color", selection: $selectedColorIndex) {
                    ForEach(0..<colors.count) {
                        Text(colors[$0])
                            .foregroundColor(Color(colors[$0]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Task Progress")) {
                Picker("Select Progress", selection: $progress) {
                    ForEach(0..<11) { percent in
                        Text("\(percent * 10)%")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            Section(header: Text("Task Deadline")) {
                DatePicker("Select Date", selection: $taskDeadline, in: Date()..., displayedComponents: .date)
            }
            
            Section(header: Text("Uploaded")) {
                HStack {
                    Text("Uploaded")
                        .bold()
                    Spacer()
                    Text(createdTime)
                        .bold()
                }
                .foregroundStyle(.gray)
                
            }
            
            Section {
                Button("Save Task") {
                    let selectedColor = colors[selectedColorIndex].lowercased()
                    let selectedTaskType = taskTypes[selectedTaskTypeIndex]

                    taskManager.editTask(task, with: taskTitle, details: taskDetails, color: selectedColor, type: selectedTaskType, progress: progress, deadline: taskDeadline, createdTime: createdTime)
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            Section {
                Button("Delete Task") {
                    showDeleteAlert.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Delete Task"),
                        message: Text("Are you sure you want to delete this task?"),
                        primaryButton: .destructive(Text("Delete")) {
                            taskManager.deleteTask(task)
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .navigationBarTitle("Edit Task")
    }
}

