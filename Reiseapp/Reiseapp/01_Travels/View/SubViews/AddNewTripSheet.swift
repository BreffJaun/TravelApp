import SwiftUI
import PhotosUI

struct AddNewTripSheet: View {
    
   // @EnvironmentObject private var addNewTripViewModel: AddNewTripViewModel
    @EnvironmentObject private var travelViewModel: TravelViewModel
    @StateObject private var addNewTripViewModel: AddNewTripViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    init(travelViewModel: TravelViewModel) {
            _addNewTripViewModel = StateObject(wrappedValue: AddNewTripViewModel(travelViewModel: travelViewModel))
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(.accentColor)
                                Text("Foto hinzufügen")
                                    .foregroundColor(.accentColor)
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                    
                    if let image = addNewTripViewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom, 10)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Allgemeine Informationen")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 10) {
                            TextField("Titel", text: $addNewTripViewModel.title)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            
                            TextField("Von", text: $addNewTripViewModel.vonOrt)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            
                            TextField("Nach", text: $addNewTripViewModel.zielOrt)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            
                            HStack {
                                Text("Abreisedatum")
                                Spacer()
                                DatePicker("", selection: $addNewTripViewModel.abreiseDatum, displayedComponents: [.date])
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Finanzen")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("Ticketpreis pro Person (€)")
                                Spacer()
                                TextField("0,00", value: $addNewTripViewModel.preisProPerson, format: .number)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 100)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                            HStack {
                                Text("Gesamtpreis")
                                Spacer()
                                Text(String(format: "%.2f € für %d Personen", addNewTripViewModel.preisGesamt, addNewTripViewModel.reisendePersonen.count))
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Mitreisende")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 10) {
                            HStack {
                                TextField("Name Mitreisender", text: $addNewTripViewModel.neuerMitreisender)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                Button(action: {
                                    addNewTripViewModel.addMitreisender()
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.accentColor)
                                        .clipShape(Circle())
                                }
                            }
                            
                            if !addNewTripViewModel.reisendePersonen.isEmpty {
                                ForEach(addNewTripViewModel.reisendePersonen, id: \.self) { name in
                                    HStack {
                                        Text(name)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    HStack(spacing: 15) {
                        Button("Speichern") {
                            addNewTripViewModel.addNewTrip()
                            dismiss()
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                        
                        Button("Abbrechen") {
                            dismiss()
                        }
                        .foregroundColor(.accentColor)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .navigationTitle("Neue Reise")
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                guard let newItem else { return }
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    addNewTripViewModel.selectedImage = uiImage
                }
            }
        }
    }
}


//#Preview {
//   AddNewTripSheet()
//}
