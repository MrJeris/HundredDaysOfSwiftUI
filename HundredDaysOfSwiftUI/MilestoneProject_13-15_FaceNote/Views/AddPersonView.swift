//
//  AddPersonView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 28.05.2023.
//

import SwiftUI
import CoreLocation

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: FaceNoteViewModel
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var location: CLLocationCoordinate2D?
    
    @State private var hasLocationSwithOn = false
    @State private var isShowingImagePicker = false
    @State private var isShowingConfirmAlert = false
    
    let locationFetcher = LocationFetcher()
    
    var hasImageAndName: Bool {
        inputImage != nil && !name.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Image") {
                    if inputImage != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        EmptyImagePlaceholder()
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                }
                .onChange(of: inputImage) { newValue in
                    guard let newValue = newValue else { return }
                    image = Image(uiImage: newValue)
                }
                
                
                Section("Name") {
                    TextField("Enter name", text: $name)
                }
                
                Section("Location") {
                    Toggle("Save Location?", isOn: $hasLocationSwithOn.animation())
                        .onChange(of: hasLocationSwithOn) { newValue in
                            if newValue == true {
                                locationFetcher.start()
                            } else {
                                location = nil
                            }
                        }
                    
                    if hasLocationSwithOn {
                        Button {
                            location = locationFetcher.lastKnownLocation
                            
                            isShowingConfirmAlert = true
                        } label: {
                            Label("Share My Current Location", systemImage: "location")
                        }
                    }
                }
            }
            .alert("Location saved!", isPresented: $isShowingConfirmAlert) {
                Button("Ok") { }
            } message: {
                Text("Your current location will be saved to remind you where you met this person")
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                //Save
                Button {
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return }
                    
                    let newPerson = Person(
                        name: name,
                        jpegData: jpegData,
                        latitude: location?.latitude,
                        longitude: location?.longitude
                    )
                    
                    viewModel.addNewPerson(newPerson)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(!hasImageAndName)
            }
        .navigationTitle("Add new person")
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(viewModel: FaceNoteViewModel())
    }
}
