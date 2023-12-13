//
//  PGTask.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import Foundation

struct PGTask: Codable, Identifiable, Hashable {
    enum Status: String, Codable, CaseIterable {
        case todo = "READY_FOR_WORK"
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
    }
    
    var id = UUID().uuidString
    var title: String
    var description: String
    var assignee: String
    var status: Status
    
//    static var mock: [Self] {
//        [
//            .init(
//                title: "Create event",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .done
//            ),
//            .init(
//                title: "Send invites",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .todo
//            ),
//            .init(
//                title: "Find a venue",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .inProgress
//            ),
//            .init(
//                title: "Fa tocana",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .todo
//            ),
//            .init(
//                title: "Win free pretzels for life",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .inProgress
//            ),
//            .init(
//                title: "Create event",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .done
//            ),
//            .init(
//                title: "Send invites",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .todo
//            ),
//            .init(
//                title: "Find a venue",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .inProgress
//            ),
//            .init(
//                title: "Fa tocana",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .todo
//            ),
//            .init(
//                title: "Win free pretzels for life",
//                description: "Lorem ipsum dolor sit amet mama ta gagica mea lololololol",
//                assignee: "deni.malan@ubb.ro",
//                status: .inProgress
//            )
//        ]
//    }
}
