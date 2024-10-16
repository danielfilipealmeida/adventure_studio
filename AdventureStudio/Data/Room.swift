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
final class Room: Codable {
    var name: String
    var desc: String
    var connections: [RoomConnection] = []
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case connections
    }
    
    init(
        name: String,
        description: String
    ) {
        self.name = name
        self.desc = description
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.connections = try container.decode([RoomConnection].self, forKey: .connections)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(persistentModelID.hashValue, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        
        let connectionIds : [Int] = connections.map(
            {(connection: RoomConnection) -> Int in
                return connection.id.hashValue
            }
        )
        try container.encode(connectionIds, forKey: .connections)
    }
}


extension Room: Hashable {
    static func == (lhs: Room, rhs: Room) -> Bool {
        lhs.name == rhs.name &&
        lhs.desc == rhs.desc &&
        lhs.connections == rhs.connections
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(desc)
        hasher.combine(connections)
    }
}
