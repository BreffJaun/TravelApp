//
//  ReiseappApp.swift
//  Reiseapp
//
//  Created by Florian Rhein on 24.03.25.
//

import SwiftUI

@main
struct ReiseappApp: App {
    
//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground() // transparent
//        appearance.backgroundColor = .clear
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.label] // optional Textfarbe
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
    
    var body: some Scene {
        WindowGroup {
            AuthView(useLocalRepository: false)
        }
    }
}
