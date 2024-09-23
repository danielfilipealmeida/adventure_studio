//
//  ObjectsListView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import SwiftUI

struct ObjectsListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var currentObject: Obj?
    @Binding var currentProject: Project?
    let objects: [Obj]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            List(selection: $currentObject) {
                ForEach(objects, id:\.self) { objects in
                    Text(objects.name)
                }
            }
            ListViewButtons(addAction: addObject, deleteAction: deleteObject)
            
        }
    }
    
    private func addObject(){
        withAnimation {
            guard let _ = currentProject else { return }
            let newObject = Obj(name: "New Object", description: "Add the object description", pickable: true)
            newObject.project = currentProject
            modelContext.insert(newObject)
        }
    }
    
    private func deleteObject() {
        withAnimation {
            guard let object = currentObject else { return }
            modelContext.delete(object)
            currentObject = nil
        }
    }
}

#Preview {
    VStack{
        @State var currentProject: Project? = Project(name: "Test Project", firstRoomIndex: 0)
        
        var objects: [Obj] = {
           return [
            Obj(name: "Key", description: "A golden key", pickable: true)
           ]
        }()
        @State var currentObject: Obj? = objects[0]
        ObjectsListView(currentObject: $currentObject, currentProject: $currentProject, objects: objects)
    }
}
