//
//  CreateTaskView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

struct CreateActivityTaskView: View {
    let didCreateTask: (ActivityTodo) -> Void
    let activityId: String
    @State var task = ActivityTodo(id: 0, title: "", description: "", asignee: "", activityId: "", status: .todo)
    var body: some View {
        VStack(spacing: 16) {
            TextField(text: $task.title, label: {
                Text("Task Title")
                    .foregroundStyle(.textPrimary)
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $task.description, axis: .vertical) {
                Text("Task Description")
                    .foregroundStyle(.textPrimary)
            }
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $task.asignee, label: {
                Text("Task Assignee")
                    .foregroundStyle(.textPrimary)
                    
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            
            Button {
                didCreateTask(task)
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 67)
                    .padding(.vertical, 8)
                    .background(Color.init(hex: "#7C7CD3"), in: RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.accent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Create")
            
        }
    }
}

struct CreateEventTaskView: View {
    let didCreateTask: (EventTodo) -> Void
    let eventId: String
    @State var task = EventTodo(id: 0, title: "", description: "", asignee: "", eventId: "", status: .inProgress)
    var body: some View {
        VStack(spacing: 16) {
            TextField(text: $task.title, label: {
                Text("Task Title")
                    .foregroundStyle(.textPrimary)
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $task.description, axis: .vertical) {
                Text("Task Description")
                    .foregroundStyle(.textPrimary)
            }
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            TextField(text: $task.asignee, label: {
                Text("Task Assignee")
                    .foregroundStyle(.textPrimary)
                    
            })
            .foregroundStyle(.textPrimary)
            .padding(8)
            .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
            
            Button {
                didCreateTask(task)
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 67)
                    .padding(.vertical, 8)
                    .background(Color.init(hex: "#7C7CD3"), in: RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(.accent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Create")
            
        }
    }
}

//#Preview {
//    CreateTaskView() { _ in }
//}
