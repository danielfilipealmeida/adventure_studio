//
//  Project.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import Foundation
import SwiftData

@Model
final class Project {
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \Room.project)
    var rooms = [Room]()
    var firstRoomIndex: Int
    
    init(name: String, rooms: [Room], firstRoomIndex: Int) {
        self.name = name
        self.rooms = rooms
        self.firstRoomIndex = firstRoomIndex
    }
}
