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
    var origin: Room
    var destiny: Room
    var direction: Direction
    var allowedInverseDirection: Bool
    
    init(origin: Room, destiny: Room, direction: Direction, allowedInverseDirection: Bool) {
        self.origin = origin
        self.destiny = destiny
        self.direction = direction
        self.allowedInverseDirection = allowedInverseDirection
    }
}
