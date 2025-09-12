//
//  Travel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation
import UIKit

struct Trip: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var departure: String
    var destination: String
    var pricePerPerson: Double
    var travelers: [String]
    var departureDate: Date
    var imageData: Data? = nil
    
    var image: UIImage? {
            get {
                guard let imageData else { return nil }
                return UIImage(data: imageData)
            }
            set {
                imageData = newValue?.jpegData(compressionQuality: 0.8)
            }
        }
    }
