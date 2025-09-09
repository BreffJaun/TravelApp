//
//  Travel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

struct Trip: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let destination: String
    let imageName: String?
}
