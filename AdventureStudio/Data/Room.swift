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

let DirectionLabels = [
    Direction.north: "North",
    Direction.south: "South",
    Direction.east: "East",
    Direction.west: "West"
]

@Model
final class Room {
    var name: String
    var desc: String
    
    var connections: [RoomConnection] = []
    
    init(
        name: String,
        description: String
    ) {
        self.name = name
        self.desc = description
    }
}
