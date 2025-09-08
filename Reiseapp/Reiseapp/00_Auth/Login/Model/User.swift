//
//  User.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var password: String
    var name: String
    var createdAt: Date
    var isDarkMode: Bool
}
