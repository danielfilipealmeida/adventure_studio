//
//  RoomConnection.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 19/09/2024.
//

import Foundation
import SwiftData

@Model
final class RoomConnection {
    
    @Relationship(inverse: \Room.connections)
    var origin: Room?
    
    @Relationship(inverse: \Room.connections)
    var destiny: Room?
    
    var direction: Direction
    var allowedInverseDirection: Bool
    
    init(origin: Room, destiny: Room, direction: Direction, allowedInverseDirection: Bool) {
        self.origin = origin
        self.destiny = destiny
        self.direction = direction
        self.allowedInverseDirection = allowedInverseDirection
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
        hasher.combine(origin)
        hasher.combine(destiny)
        hasher.combine(direction)
        hasher.combine(allowedInverseDirection)
    }
}

