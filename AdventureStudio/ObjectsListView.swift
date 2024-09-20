//
//  ObjectsListView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import SwiftUI

struct ObjectsListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var currentObject: Object?
    let objects: [Object]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            List(selection: $currentObject) {
                ForEach(objects, id:\.self) { objects in
                    Text(objects.name)
                }
            }
            
        }
    }
}

#Preview {
    VStack{
        @State var currentProject: Project? = Project(name: "Test Project", firstRoomIndex: 0)
        
        var objects: [Object] = {
           return [
            Object(name: "Key", description: "A golden key", pickable: true)
           ]
        }()
        @State var currentObject: Object? = objects[0]
        ObjectsListView(currentObject: $currentObject, objects: objects)
    }
}
