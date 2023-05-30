//
//  PersonDetailView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 29.05.2023.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    var person: Person
    
    var body: some View {
        VStack(spacing: 20) {
            person.image?
                .resizable()
                .scaledToFit()
            
            if let coordinate = person.coordinate {
                VStack {
                    Label("That's where you took this photo", systemImage: "map")
                        .font(.headline)
                    
                    Map(coordinateRegion:
                            .constant(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: coordinate.latitude,
                                    longitude: coordinate.longitude
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.2,
                                    longitudeDelta: 0.2
                                )
                            )),
                        annotationItems: [person]) { _ in
                        MapAnnotation(coordinate: coordinate) {
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                                .frame(width: 64, height: 64)
                        }
                    }
                }
            } else {
                Label("Unknown meeting location...", systemImage: "questionmark")
                    .font(.headline)
            }
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
