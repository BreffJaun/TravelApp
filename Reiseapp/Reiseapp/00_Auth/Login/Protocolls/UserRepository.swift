//
//  QuoteRepository.swift
//  Sylando
//
//  Created by Jeff Braun on 04.09.25.
//

import Foundation

protocol UserRepository {
    func login(email: String, password: String) async throws -> User
}


