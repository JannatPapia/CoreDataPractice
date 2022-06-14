//
//  ContentView.swift
//  CoreDataPractice
//
//  Created by Jannatun Nahar Papia on 11/6/22.
//

import SwiftUI



struct DoneTaskView: View {

    @Environment(\.managedObjectContext) private var viewContex
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>

    
    private func styleForPriority(_ value: String) -> Color {
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .low:
            return Color.green
        case .medium:
            return Color.orange
        case .high:
            return Color.red
        default:
            return Color.black
        }
    }
    
    private func updateTask(_ task: Task) {
        task.isFavorite = !task.isFavorite
        
        do {
            try viewContex.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func deleteExercise(_ task: Task) { //I'm making an assumption that your model is called Exercise
        withAnimation {
            viewContex.delete(task)
            do {
                try viewContex.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
         
            VStack {
                
                
                
                List {
                    //allTasks aplly filter on it
                    ForEach(allTasks.filter({$0.isFavorite == true })) { task in
                        HStack {
                            Circle()
                                .fill(styleForPriority(task.priority!))
                                .frame(width: 15, height: 15)
                            Spacer().frame(width: 20)
                            
                            Button(action: {
                                //   deleteTask()
                                deleteExercise(task)
                            }, label: {
                                Image(systemName: "trash")
                                //   Label("", systemImage: "trash")
                                    .foregroundColor(.blue)
                            })
                            
                            
                            Text(task.title ?? "")
                            
                            Spacer()
                            
                            Text("Undone")
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    updateTask(task)
                                }
                        }
                    }
                    //       .onDelete(perform: deleteTask)
                }
                
                Spacer()
            
            
        }
    }
}

struct DoneTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        DoneTaskView().environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
