//
//  ClearableTextField.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 10.09.25.
//

// 02_Flights/View/ClearableTextField.swift
import SwiftUI

struct ClearableTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(placeholder, text: $text)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .padding(.trailing, 8)
            }
        }
    }
}
#Preview {
    ClearableTextField(placeholder: "Startort", text: .constant("Hallo"))
}

