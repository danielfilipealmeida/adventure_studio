//
//  Exporter.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 03/10/2024.
//

import Foundation


enum ExporterError: Error {
    case convertToJSON
}


final class Exporter: Codable {
    var url: URL
    var rooms: [Room]
    
    private enum CodingKeys: String, CodingKey {
        case rooms
    }
    
    init(url: URL, rooms: [Room]) {
        self.url = url
        self.rooms = rooms
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rooms = try container.decode([Room].self, forKey: .rooms)
        self.url = Bundle.main.executableURL!
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rooms, forKey: .rooms)
        
    }
    
    func run() throws {
        let jsonEncoder: JSONEncoder = JSONEncoder()
        let jsonData: Data = try jsonEncoder.encode(self)
        
        let fm: FileManager = .default
        try fm.createDirectory(at: self.url, withIntermediateDirectories: true)
        
        try jsonData.write(to: self.url.appending(component: "data.json"))
    }
    
}

extension Exporter: Hashable {
    static func == (lhs: Exporter, rhs: Exporter) -> Bool {
        lhs.rooms == rhs.rooms
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rooms)
    }
}
