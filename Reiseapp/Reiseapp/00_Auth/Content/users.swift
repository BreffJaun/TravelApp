//
//  users.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

var dummyUsers = [
    User(id: UUID(), email: "testuser@mail.com", password: "test123", name: "Max Mustermann", createdAt: .now, isDarkMode: false),
    User(id: UUID(), email: "anna@mail.com", password: "geheim", name: "Anna Müller", createdAt: .now, isDarkMode: true),
    User(id: UUID(), email: "john@mail.com", password: "swiftrocks", name: "John AppDev", createdAt: .now, isDarkMode: false)
]
