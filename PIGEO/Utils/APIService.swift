//
//  APIService.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import Foundation
import Alamofire
import SwiftMessages

struct EventResponse: Codable {
    let events: [Event]
}

class APIService {
    static let shared = APIService()
    private let baseURL = "https://76d5-89-238-224-254.ngrok-free.app"
    
    @MainActor
    func login(user: User, completionHandler: @escaping () -> ()) {
        let parameters = [
            "email": user.email.lowercased()
        ]
        
        AF.request(
            "\(baseURL)/user",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { _ in
            completionHandler()
        }
    }
    
    // Request body: { requesterEmail: "...", userEmail: "...", eventId: "..." }
    // Response if successful:
    //     - Status: 200
    // Response if failed:
    //     - Status: 401
    //    usersRbacRouter.patch(
    //      "/grant-event-admin",
    //      UsersRbacController.grantEventAdminAccess,
    //    );
    //requester - ala de vrea sa dea admin
    //userEmail - ala de i se da admin
    //eventId - id
    func grantEventAdmin(
        requesterEmail: String,
        userEmail: String,
        eventId: String,
        completionHandler: @escaping (Result<Void?, AFError>) -> Void
    ) {
        let parameters = [
            "requesterEmail": requesterEmail,
            "userEmail": userEmail,
            "eventId": eventId
        ]
        AF.request(
            "\(baseURL)/grant-event-admin",
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    // Request body: { requesterEmail: "...", userEmail: "...", activityId: "..." }
    // Response if successful:
    //     - Status: 200
    // Response if failed:
    //     - Status: 401
    //    usersRbacRouter.patch(
    //      "/grant-activity-admin",
    //      UsersRbacController.grantActivityAdminAccess,
    //    );
    func grantActivityAdmin(
        requesterEmail: String,
        userEmail: String,
        eventId: String,
        completionHandler: @escaping (Result<Void?, AFError>) -> Void
    ) {
        let parameters = [
            "requesterEmail": requesterEmail,
            "userEmail": userEmail,
            "eventId": eventId
        ]
        AF.request(
            "\(baseURL)/grant-activity-admin",
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Request body: { requesterEmail: "...", userEmail: "...", eventId: "..." }
    // Response if successful:
    //     - Status: 200
    // Response if failed:
    //     - Status: 401
    //    usersRbacRouter.patch(
    //      "/revoke-event-admin",
    //      UsersRbacController.revokeEventAdminAccess,
    //    );
    func revokeEventAdmin(
        requesterEmail: String,
        userEmail: String,
        eventId: String,
        completionHandler: @escaping (Result<Void?, AFError>) -> Void
    ) {
        let parameters = [
            "requesterEmail": requesterEmail,
            "userEmail": userEmail,
            "eventId": eventId
        ]
        AF.request(
            "\(baseURL)/revoke-event-admin",
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Request body: { requesterEmail: "...", userEmail: "...", activityId: "..." }
    // Response if successful:
    //     - Status: 200
    // Response if failed:
    //     - Status: 401
    //    usersRbacRouter.patch(
    //      "/revoke-activity-admin",
    //      UsersRbacController.revokeActivityAdminAccess,
    //    );
    
    func revokeActivityAdmin(
        requesterEmail: String,
        userEmail: String,
        eventId: String,
        completionHandler: @escaping (Result<Void?, AFError>) -> Void
    ) {
        let parameters = [
            "requesterEmail": requesterEmail,
            "userEmail": userEmail,
            "eventId": eventId
        ]
        AF.request(
            "\(baseURL)/revoke-activity-admin",
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getEvents(requesterEmail: String, completionHandler: @escaping (Result<[Event], AFError>) -> Void) {
        let parameters = [
            "requesterEmail": requesterEmail
        ]
        
        AF.request(
            "\(baseURL)/event",
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: .init([.contentType("application/json")])
        ) //ioan.preoteasa@stud.ubbcluj.ro
//        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedEvents = try JSONDecoder().decode([Event].self, from: data)
//                    print(decodedEvents)
                    completionHandler(.success(decodedEvents))
                } catch {
                    print(error)
                    completionHandler(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func inviteToEvent(requesterEmail: String, userEmail: String, eventId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "requesterEmail": requesterEmail,
            "userEmail": userEmail,
            "eventId": eventId
        ]
        
        AF.request(
            "\(baseURL)/event/invite",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createEvent(name: String, description: String, creator: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "name": name,
            "description": description,
            "creator": creator
        ]
        
        AF.request(
            "\(baseURL)/event",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createActivity(name: String, description: String, creator: String, eventId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "name": name,
            "description": description,
            "requesterEmail": creator,
            "eventId": eventId
        ]
        
        AF.request(
            "\(baseURL)/activity",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func joinActivity(userEmail: String, activityId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "userEmail": userEmail,
            "activityId": activityId
        ]
        
        AF.request(
            "\(baseURL)/activity/join",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createEventTodo(title: String, description: String, assignee: String, eventId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "title": title,
            "description": description,
            "asignee": assignee,
            "eventId": eventId
        ]
        
        AF.request(
            "\(baseURL)/todo/event",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func updateActivityTodo(todoId: String, status: PGTask.Status, type: TodoType, eventId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "todoId": todoId,
            "status": status.rawValue.uppercased(),
            "type": type.rawValue
        ]
        
        AF.request(
            "\(baseURL)/todo",
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createActivityTodo(title: String, description: String, assignee: String, eventId: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "title": title,
            "description": description,
            "asignee": assignee,
            "activityId": eventId
        ]
        
        AF.request(
            "\(baseURL)/todo/activity",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func rateActivity(score: Int, activityId: String, userEmail: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "score": "\(score)",
            "activityId": activityId,
            "userEmail": userEmail
        ]
        
        AF.request(
            "\(baseURL)/rate/activity",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func rateEvent(score: Int, eventId: String, userEmail: String, completionHandler: @escaping (Result<Void?, AFError>) -> Void) {
        let parameters = [
            "score": "\(score)",
            "eventId": eventId,
            "userEmail": userEmail
        ]
        
        AF.request(
            "\(baseURL)/rate/event",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success:
                completionHandler(.success(nil))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getEventStatistics(eventId: String, completionHandler: @escaping (Result<Statistics, AFError>) -> Void) {
        let parameters = [
            "eventId": eventId,
        ]
        
        AF.request(
            "\(baseURL)/event/statistics",
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<299)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedEvents = try JSONDecoder().decode(Statistics.self, from: data)
//                    print(decodedEvents )
                    completionHandler(.success(decodedEvents))
                } catch {
                    print(error)
                    completionHandler(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

enum TodoType: String {
    case event = "EVENT"
    case activity = "ACTIVITY"
}
