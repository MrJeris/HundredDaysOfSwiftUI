//
//  PersonDetailView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 29.05.2023.
//

import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        VStack(spacing: 20) {
            person.image?
                .resizable()
                .scaledToFit()
        }
        .padding()
        .navigationTitle(person.name)
    }
}

//struct PersonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailView()
//    }
//}
