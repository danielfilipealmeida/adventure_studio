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

extension Obj: Hashable {
    static func == (lhs: Obj, rhs: Obj) -> Bool {
        lhs.name == rhs.name &&
        lhs.desc == rhs.desc &&
        lhs.pickable == rhs.pickable
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(desc)
        hasher.combine(pickable)
    }
}
