//
//  FaceNoteViewModel.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 28.05.2023.
//

import Foundation

class FaceNoteViewModel: ObservableObject {
    @Published var people: [Person]
    
    let savePath = FileManager.documentDirectory.appendingPathComponent("SavePersons")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            people = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addNewPerson(_ person: Person) {
        people.append(person)
        people.sort()
        save()
    }
    
    func removePerson(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
}
