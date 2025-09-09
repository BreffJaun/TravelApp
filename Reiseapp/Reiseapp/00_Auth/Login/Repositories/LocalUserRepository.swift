//
//  LocalUserRepository.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import Foundation

class LocalUserRepository: UserRepository {
    private let users: [User]
    
    init(users: [User] = dummyUsers) {
        self.users = users
    }
    
    func login(email: String, password: String) async throws -> User {
        guard let user = users.first(where: {
            $0.email == email && $0.password == password
        }) else {
            throw AuthError.invalidCredentials
        }
        return user
    }
}
