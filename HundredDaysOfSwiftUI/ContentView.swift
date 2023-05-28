//
//  ContentView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 22.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Face Note View") {
                FaceNoteView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
