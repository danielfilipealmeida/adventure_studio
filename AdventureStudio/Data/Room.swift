//
//  Room.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import Foundation
import SwiftData

enum Direction: Codable {
    case north
    case south
    case east
    case west
}

@Model
final class Room {
    var name: String
    var desc: String
    var project: Project?
    //var rooms: Dictionary<Directions, Room>?
    
    init(
        name: String,
        description: String,
        project: Project?
    ) {
        self.name = name
        self.desc = description
        self.project = project
    }
}
