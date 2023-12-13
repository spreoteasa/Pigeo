//
//  UserDefaultsService.swift
//  PIGEO
//
//  Created by Preoteasa Ioan-Silviu on 18.11.2023.
//

import Foundation

class UserDefaultsService {
    enum Keys: String {
        case user
    }
    static let shared = UserDefaultsService()
    
    func saveUser(user: User) {
        do {
            let encoded = try JSONEncoder().encode(user)
            UserDefaults.standard.setValue(encoded, forKey: Keys.user.rawValue)
        } catch {
            print(error)
        }
    }
    
    func getUser() -> User? {
        guard let savedUser = UserDefaults.standard.data(forKey: Keys.user.rawValue) else { return nil }
        guard let user = try? JSONDecoder().decode(User.self, from: savedUser) else { return nil }
        return user
    }
}
