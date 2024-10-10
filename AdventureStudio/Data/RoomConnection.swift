//
//  RoomConnection.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 19/09/2024.
//

import Foundation
import SwiftData

@Model
final class RoomConnection: Codable {
    
    @Relationship(inverse: \Room.connections)
    var origin: Room?
    
    @Relationship(inverse: \Room.connections)
    var destiny: Room?
    
    var direction: Direction
    var allowedInverseDirection: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case origin
        case destiny
        case direction
        case allowedInverseDirection
    }
    
    init(origin: Room, destiny: Room, direction: Direction, allowedInverseDirection: Bool) {
        self.origin = origin
        self.destiny = destiny
        self.direction = direction
        self.allowedInverseDirection = allowedInverseDirection
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.origin = try container.decode(Room.self, forKey: .origin)
        self.destiny = try container.decode(Room.self, forKey: .destiny)
        self.direction = try container.decode(Direction.self, forKey: .direction)
        self.allowedInverseDirection = try container.decode(Bool.self, forKey: .allowedInverseDirection)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(persistentModelID.hashValue, forKey: .id)
        try container.encode(origin?.persistentModelID.hashValue, forKey: .origin)
        try container.encode(destiny?.persistentModelID.hashValue, forKey: .destiny)
        try container.encode(direction, forKey: .direction)
        try container.encode(allowedInverseDirection, forKey: .allowedInverseDirection)
    }
}

extension RoomConnection: Hashable {
    static func == (lhs: RoomConnection, rhs: RoomConnection) -> Bool {
        lhs.origin == rhs.origin &&
        lhs.destiny == rhs.destiny &&
        lhs.direction == rhs.direction &&
        lhs.allowedInverseDirection == rhs.allowedInverseDirection
    }
    
    func hash(into hasher: inout Hasher) {
        if let _origin = self.origin {
            hasher.combine(_origin)
        }
        //hasher.combine(self.origin)
        hasher.combine(self.destiny)
        hasher.combine(self.direction)
        hasher.combine(self.allowedInverseDirection)
    }
}

