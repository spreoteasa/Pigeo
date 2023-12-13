//
//  MainCoordinatorView.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import SwiftUI

class UserContainer: ObservableObject {
    @Published var user = User(email: "", password: "")
}

struct MainCoordinatorView: View {
    @StateObject private var viewModel = ViewModel()
    @State var user = User(email: "ioan.preoteasa@stud.ubbcluj.ro", password: "")
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            getScreen(viewModel.screen)
                .navigationDestination(for: ViewModel.Screens.self) { screen in
                    getScreen(screen)
                        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                        .navigationBarTitleDisplayMode(.inline)
                }
        }
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func getScreen(_ state: ViewModel.Screens) -> some View {
        switch state {
        case .login:
            RegisterView() { user in
                self.user = user
                viewModel.navigationPath.append(ViewModel.Screens.main)
            }
        case .main:
            MainView(user: user, goToEvent: { event in
                viewModel.navigationPath.append(ViewModel.Screens.event(event))
            })
        case .activityTodos(let todos):
            ActivityTodoView(activityTodos: todos)
        case .eventTodos(let todos):
            EventTodoView(eventTodos: todos)
        case .event(let event):
            let isAdmin = event.adminList.contains(user.email)
            EventView(event: event, isAdmin: isAdmin, user: user) { activity in
                viewModel.navigationPath.append(ViewModel.Screens.activity(activity))
            } seeAttendees: { attendees in
                viewModel.navigationPath.append(ViewModel.Screens.attendees(attendees))
            } seeStatistics: { event in
                viewModel.navigationPath.append(ViewModel.Screens.statistics(event))
            } seeTodo: { event in
                viewModel.navigationPath.append(ViewModel.Screens.eventTodos(event.todos))
            }
        case .activity(let activity):
            let isAdmin = activity.adminList.contains(user.email)
            ActivityView(activity: activity, user: user, isAdmin: isAdmin) { activity in
                viewModel.navigationPath.append(ViewModel.Screens.activityTodos(activity.todos))
            }
        case .attendees(let attendees):
            AttendeesView(attendees: attendees)
        case .statistics(let event):
            StatisticsView(event: event)
        }
    }
}

extension MainCoordinatorView {
    class ViewModel: ObservableObject {
        enum Screens: Hashable {
            case login
            case main
            case eventTodos([EventTodo])
            case activityTodos([ActivityTodo])
            case event(Event)
            case activity(Activity)
            case attendees([String])
            case statistics(Event)
        }
        
        @Published var screen: Screens = .login
        @Published var navigationPath = NavigationPath()
    }
}

#Preview {
    MainCoordinatorView()
}
