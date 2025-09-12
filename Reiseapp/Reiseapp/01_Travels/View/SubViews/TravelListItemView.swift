//
//  TravelListViewItem.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import SwiftUI

struct TravelListItemView: View {
    
    let trip: Trip
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageName = trip.image {
                Image(uiImage: imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(trip.destination)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("AccentColor").opacity(0.8))
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("SecondaryGradientStart"),
                    Color("SecondaryGradientEnd")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

//#Preview {
//    TravelListItemView()
//}


