//
//  Object.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import Foundation
import SwiftData

@Model
final class Obj: Codable {
    var name: String
    var desc: String
    var pickable: Bool
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name
        case desc
        case pickable
    }
    
    init(name: String, description: String, pickable: Bool) {
        self.name = name
        self.desc = description
        self.pickable = pickable
    }
    
    init(from decoder: any Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.pickable = try container.decode(Bool.self, forKey: .pickable)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(persistentModelID.hashValue, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(pickable, forKey: .pickable)
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
