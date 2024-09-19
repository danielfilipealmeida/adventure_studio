//
//  PreviewModelContainer.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 19/09/2024.
//

import Foundation
import SwiftData

@MainActor func getPreviewModelContainer(projectsData: [Dictionary<String, Any>]) -> ModelContainer {
    do {
        let schema = Schema([
            Project.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            let modelContainer =  try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            /*
            let projectsData:[Dictionary] = [
              [
                  "name": "Project one",
                  "rooms": [
                      [
                          "name": "Garden",
                          "desc": "Lorem Ipsum"
                      ],
                      [
                          "name": "Porch",
                          "desc": "blah blah"
                      ]
                  ]
              ],
              [
                  "name": "Project two",
                  "rooms": []
              ]
            ]
             */
            
            
            for project in projectsData {
                
               var rooms:[Room] = {
                   var rooms: [Room] = []
                   for room in project["rooms"] as! [Dictionary<String, String>] {
                       let newRoom = Room(name: room["name"] ?? "", description: room["desc"] ?? "", project: nil)
                       //modelContainer.mainContext.insert(newRoom)
                       rooms.append(newRoom)
                   }
                   
                   return rooms
               }()
                 
               let newProject = Project(name: project["name"] as! String, rooms: rooms, firstRoomIndex: project["firstRoomIndex"] as? Int ?? 0)
                
               
                modelContainer.mainContext.insert(newProject)
            }
             
            
            return modelContainer
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
