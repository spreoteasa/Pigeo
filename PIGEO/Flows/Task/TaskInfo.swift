//
//  TaskInfo.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI
import SwiftMessages

struct ActivityTaskInfo: View {
    @State private var expandView = false
    @Binding var task: ActivityTodo
    
    var body: some View {
        VStack {
            Button {
                expandView.toggle()
            } label: {
                HStack {
                    Text(task.title)
                    Spacer()
                    Image(systemName: expandView ? "chevron.down" :  "chevron.right")
                        .renderingMode(.template)
                }
                .fontWeight(.bold)
            }
            
            if expandView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.description)
                        Picker("task.status.rawValue", selection: $task.status) {
                            ForEach(PGTask.Status.allCases, id: \.self) { status in
                                Text(status.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: task.status) {
                            UserNotificationCenter.shared.notifyUsers(task)
                        }
                    }
                    Spacer()
                }
            }
        }
        .foregroundStyle(.textPrimary)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
        .transition(.slide)
        .animation(.default, value: expandView)
    }
    
    
}

struct EventTaskInfo: View {
    @State private var expandView = false
    @Binding var task: EventTodo
    
    var body: some View {
        VStack {
            Button {
                expandView.toggle()
            } label: {
                HStack {
                    Text(task.title)
                    Spacer()
                    Image(systemName: expandView ? "chevron.down" :  "chevron.right")
                        .renderingMode(.template)
                }
                .fontWeight(.bold)
            }
            
            if expandView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.description)
                        Picker("task.status.rawValue", selection: $task.status) {
                            ForEach(PGTask.Status.allCases, id: \.self) { status in
                                Text(status.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: task.status) {
//                            UserNotificationCenter.shared.notifyUsers(task)
                        }
                    }
                    Spacer()
                }
            }
        }
        .foregroundStyle(.textPrimary)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.lightPurple, in: RoundedRectangle(cornerRadius: 14))
        .transition(.slide)
        .animation(.default, value: expandView)
    }
    
    
}
