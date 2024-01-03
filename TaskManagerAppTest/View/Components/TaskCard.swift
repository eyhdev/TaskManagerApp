//
//  TaskCard.swift
//  TaskManagerAppTest
//
//  Created by eyh.mac on 6.01.2024.
//

import SwiftUI

struct TaskCard: View {
    var task: Task
    @StateObject var taskManager: TaskManager

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Type
            HStack {
                Text(task.type ?? "")
                    .foregroundColor(.white)
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.brown.opacity(0.8))
                    }
                Spacer()
                Text(task.isDone ? "100%" : "\(task.progress)0%")
                    .foregroundColor(.white)
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.blue.opacity(0.8))
                    }
            }

            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical)

            Text(task.details ?? "")
                .font(.subheadline.bold())
                .foregroundColor(.black)
                .padding(.vertical, 10)

            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)

                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    taskManager.toggleTaskStatus(task)
                } label: {
                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(.ultraThinMaterial))
    }
}
