//
//  FileManager-DocumentsDirectory.swift
//  HundredDaysOfSwiftUI
//
//  Created by Ruslan Magomedov on 25.05.2023.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
