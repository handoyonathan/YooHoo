//
//  Buddy.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//

import SwiftUI
import SwiftData

@Model
class Buddy: Identifiable {
    var name: String
    var image: String
    var experience: String
    
    init(id: UUID = UUID(), name: String, image: String, description: String) {
        self.name = name
        self.image = image
        self.experience = description
    }
}
