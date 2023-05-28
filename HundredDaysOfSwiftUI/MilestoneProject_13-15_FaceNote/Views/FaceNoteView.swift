//
//  FaceNoteView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 28.05.2023.
//

import SwiftUI

struct FaceNoteView: View {
    @StateObject var viewModel = FaceNoteViewModel()
    
    @State private var isShowingAddView = false
    
    var body: some View {
        List {
            ForEach(viewModel.people) { person in
                NavigationLink {
                    PersonDetailView(person: person)
                } label: {
                    HStack {
                        person.image?
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        Text(person.name)
                    }
                }
            }
            .onDelete(perform: viewModel.removePerson)
        }
        .navigationTitle("Face Note")
        .sheet(isPresented: $isShowingAddView) {
            AddPersonView(viewModel: viewModel)
        }
        .toolbar {
            Button {
                isShowingAddView = true
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

struct FaceNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FaceNoteView()
        }
    }
}
