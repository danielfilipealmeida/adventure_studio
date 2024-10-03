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

class Exporter {
    var url: URL
    var rooms: [Room]
    
    
    init(url: URL, rooms: [Room]) {
        self.url = url
        self.rooms = rooms
    }
    
    func run() throws {
        let data: [String: Any] = [
            "rooms": self.rooms
        ]
        
        let encodedData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        try encodedData.write(to: self.url)
    }
    
}
