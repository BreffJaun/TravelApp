//
//  RemoteUserRepository.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import Foundation

class RemoteUserRepository: UserRepository {
    func login(email: String, password: String) async throws -> User {
        // Später hier echte API-Abfrage
        throw HTTPError.noData
    }
}
