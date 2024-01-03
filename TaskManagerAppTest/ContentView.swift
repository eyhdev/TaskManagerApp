//
//  ContentView.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 3.01.2024.
//



import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingLogin = true
    @StateObject var taskManager: TaskManager
    @State private var isShowingAddTaskSheet = false
    var body: some View {
        NavigationView {
            if taskManager.currentUser != nil {
                BottomSections()
                    .navigationTitle("Task Manager")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $isShowingAddTaskSheet) {
                        AddTaskView(isPresented: $isShowingAddTaskSheet) { title, details, color, type, progress, deadline in
                            taskManager.addTask(title: title, details: details, color: color, type: type, progress: progress, deadline: deadline)
                        }
                    }
                    .navigationBarItems(
                        leading: Button(action: {
                            taskManager.signOut()
                        }, label: {
                            Text("Sign Out")
                                .foregroundStyle(.red)
                                .font(.callout)
                        }),
                        trailing: Button(action: {
                            isShowingAddTaskSheet.toggle()
                        }) {
                            Label {
                                Text("Add Task")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                
                            } icon: {
                                Image(systemName: "plus.app.fill")
                            }
                            .foregroundColor(.white)
                            .padding(5)
                            .background(.brown , in:Capsule())
                        }
                    )
            } else {
                VStack {
                    AuthView(taskManager: taskManager)
                }
                .padding()
                .navigationTitle("Authentication")
            }
        }
        .accentColor(.brown)
    }
}
