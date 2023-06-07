//
//  HotProspectsView.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 31.05.2023.
//

import SwiftUI

struct HotProspectsView: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct HotProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotProspectsView()
        }
    }
}
