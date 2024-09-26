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
    var rooms: [Room] = []
    
    @Relationship(inverse: \Obj.project)
    var objects: [Obj] = []
    
    @Relationship(inverse: \Obj.project)
    var connections: [RoomConnection] = []
    
    var firstRoomIndex: Int
    
    init(
        name: String,
        firstRoomIndex: Int
    ) {
        self.name = name
        self.firstRoomIndex = firstRoomIndex
    }
}
