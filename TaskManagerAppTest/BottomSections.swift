//
//  BottomSections.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 6.01.2024.
//

import SwiftUI

struct BottomSections: View {
    var body: some View {
        TabView {
            TasksList(taskManager: TaskManager())
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                }
            
            CompletedTasks(taskManager: TaskManager())
                .tabItem {
                    Image(systemName: "text.badge.checkmark")
                }
            ExpiredTasks(taskManager: TaskManager())
                .tabItem {
                    Image(systemName: "xmark.app.fill")
                }
        }
        
    }
}

#Preview {
    BottomSections()
}
