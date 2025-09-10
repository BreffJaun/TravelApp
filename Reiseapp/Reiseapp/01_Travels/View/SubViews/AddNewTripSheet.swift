import SwiftUI
import PhotosUI

struct AddNewTripSheet: View {
    
    @EnvironmentObject private var  addNewTripViewModel: AddNewTripViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    var preisGesamt: Double {
        addNewTripViewModel.preisProPerson * Double(addNewTripViewModel.reisendePersonen.count)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(.purple)
                                Text("Foto hinzufügen")
                                    .foregroundColor(.purple)
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Allgemeine Informationen")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 0) {
                            TextField("Titel", text: $addNewTripViewModel.titel)
                                .padding(.horizontal)
                            Divider()
                            TextField("Von", text: $addNewTripViewModel.vonOrt)
                                .padding(.horizontal)
                            Divider()
                            TextField("Nach", text: $addNewTripViewModel.zielOrt)
                                .padding(.horizontal)
                            Divider()
                            HStack {
                                Text("Abreisedatum")
                                Spacer()
                                DatePicker("", selection: $addNewTripViewModel.abreiseDatum, displayedComponents: [.date])
                                    .labelsHidden()
                            }
                            .padding(.horizontal)
                            .frame(height: 44)
                        }
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Finanzen")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("Ticketpreis pro Person (€)")
                                Spacer()
                                TextField("0,00", value: $preisProPerson, format: .number)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 100)
                            }
                            .padding(.horizontal)
                            Divider()
                            HStack {
                                Text("Gesamtpreis")
                                Spacer()
                                Text(String(format: "%.2f € für %d Personen", preisGesamt, reisendePersonen.count))
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mitreisende")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 0) {
                            HStack {
                                TextField("Name Mitreisender", text: $neuerMitreisender)
                                Button(action: {
                                    if !neuerMitreisender.isEmpty {
                                        reisendePersonen.append(neuerMitreisender)
                                        neuerMitreisender = ""
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.purple)
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                            
                            ForEach(reisendePersonen, id: \.self) { name in
                                Text(name)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Divider()
                            }
                        }
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    VStack(spacing: 12) {
                        Button(action: {
                            
                        }) {
                            Text("Speichern")
                                .foregroundColor(.purple)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Abbrechen")
                                .foregroundColor(.purple)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Neue Reise")
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }

    }
}

//#Preview {
//   AddNewTripSheet()
//}
