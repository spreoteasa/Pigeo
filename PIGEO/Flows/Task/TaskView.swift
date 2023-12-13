//
//  TaskView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

struct EventTodoView: View {
    @State var eventTodos: [EventTodo] = []
    @State private var showSheet = false
    var body: some View {
        VStack {
            ScrollView {
                ForEach($eventTodos) { task in
                    EventTaskInfo(task: task)
                }
            }
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(babyBlue, in: .circle)
                    .padding(.vertical, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hex: "#200D2F"))
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showSheet) {
            CreateEventTaskView(didCreateTask: { newTask in
                let x = EventTodo(
                    id: 0,
                    title: newTask.title,
                    description: newTask.description,
                    asignee: newTask.asignee,
                    eventId: eventTodos[0].eventId,
                    status: .todo
                )
                eventTodos.append(x)
                APIService.shared.createEventTodo(title: x.title, description: x.description, assignee: x.asignee, eventId: x.eventId) { result in
                    switch result {
                    case .success(_):
                        print("x")
                    case .failure(let failure):
                        print(failure)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showSheet = false
                }
                
            }, eventId: eventTodos[0].eventId)
            .presentationDetents([.fraction(0.8)])
        }
        
    }
}


struct ActivityTodoView: View {
    @State var activityTodos: [ActivityTodo] = []
    @State private var showSheet = false
    var body: some View {
        VStack {
            ScrollView {
                ForEach($activityTodos) { task in
                    ActivityTaskInfo(task: task)
                }
            }
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(babyBlue, in: .circle)
                    .padding(.vertical, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hex: "#200D2F"))
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showSheet) {
            CreateActivityTaskView(didCreateTask: {
                newTask in
                let x = ActivityTodo(
                    id: 0,
                    title: newTask.title,
                    description: newTask.description,
                    asignee: newTask.asignee,
                    activityId: activityTodos[0].activityId,
                    status: .todo
                )
                activityTodos.append(x)
                APIService.shared.createActivityTodo(title: x.title, description: x.description, assignee: x.asignee, eventId: x.activityId) { result in
                    switch result {
                    case .success(_):
                        print("x")
                    case .failure(let failure):
                        print(failure)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showSheet = false
                }
            },
                                   activityId: activityTodos[0].activityId)
            .presentationDetents([.fraction(0.8)])
        }
        
    }
}
//
//#Preview {
//    TaskView(tasks: PGTask.mock)
//}

//
//#Preview {
//    TaskView(tasks: PGTask.mock)
//}
