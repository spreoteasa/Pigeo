//
//  Event.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import Foundation

struct ActivityTodo: Codable, Identifiable, Hashable {
    let id: Int
    var title: String
    var description: String
    var asignee: String
    var activityId: String
    var status: PGTask.Status
}

struct EventTodo: Codable, Identifiable, Hashable {
    let id: Int
    var title: String
    var description: String
    var asignee: String
    var eventId: String
    var status: PGTask.Status
}

struct Activity: Codable, Identifiable, Hashable {
    let id: Int
    var name: String
    var description: String
    var attendees: [String]
    let adminList: [String]
    let rated: Bool
    let todos: [ActivityTodo]
}

struct Event: Codable, Identifiable, Hashable {
    let id: Int
    var name: String
    var description: String
    let creator: String
    let rated: Bool
    let adminList: [String]
    var attendees: [String]
    var activities: [Activity]
    let todos: [EventTodo]
}
