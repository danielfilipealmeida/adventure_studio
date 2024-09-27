//
//  Object.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import Foundation
import SwiftData

@Model
final class Obj {
    var name: String
    var desc: String
    var pickable: Bool
    
    init(name: String, description: String, pickable: Bool) {
        self.name = name
        self.desc = description
        self.pickable = pickable
    }
}
