//
//   FlightAPI.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 10.09.25.
//

import Foundation

struct FlightAPI {
    static let baseURL = "https://example.com/flights"


    static func makeSearchRequest(from: String, to: String, date: Date) -> URLRequest? {
        guard var components = URLComponents(string: baseURL) else {
            return nil
        }
        

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        components.queryItems = [
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "to", value: to),
            URLQueryItem(name: "date", value: formatter.string(from: date))
        ]
        
        

        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    
    
}

