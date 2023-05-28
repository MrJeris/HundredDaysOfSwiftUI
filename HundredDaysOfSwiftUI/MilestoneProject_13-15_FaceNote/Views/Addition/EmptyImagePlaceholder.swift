//
//  EmptyImagePlaceholder.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 29.05.2023.
//

import SwiftUI

struct EmptyImagePlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    .blue,
                    style: .init(
                    lineWidth: 2,
                    lineCap: .round,
                    dash: [5, 5])
                )
                .scaledToFit()
            
            Text("Tap to select an image")
                .foregroundColor(.blue)
                .font(.headline)
        }
    }
}

struct EmptyImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImagePlaceholder()
    }
}
