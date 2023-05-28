//
//  AddPersonView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 28.05.2023.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: FaceNoteViewModel
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var isShowingImagePicker = false
    @State private var isShowingConfirmAlert = false
    
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
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                //Save
                Button {
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return }
                    
                    let newPerson = Person(name: name, jpegData: jpegData)
                    
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
