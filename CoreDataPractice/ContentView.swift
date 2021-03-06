//
//  ContentView.swift
//  CoreDataPractice
//
//  Created by Jannatun Nahar Papia on 11/6/22.
//

import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
    
    var title: String {
        switch self {
        case.low:
            return "Low"
        case.medium:
            return "Medium"
        case.high:
            return "High"
        }
    }
}

struct ContentView: View {
    
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContex
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
    
    private func saveTask() {
        do {
            let task = Task(context: viewContex)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            try viewContex.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
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
    
//    private func deleteTask(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let task = allTasks[index]
//            viewContex.delete(task)
//            
//            do {
//                try viewContex.save()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    
    
    
    
    
    
    private func deleteExercise(_ task: Task) { //I'm making an assumption that your model is called Exercise
      withAnimation {
          viewContex.delete(task)
          
          
          do {
              try viewContex.save()
          } catch {
              print(error.localizedDescription)
          }
 //         viewContex.save()
      }
    }
    
//    private func delete(at index: Int){
//        viewContex.remove(at: index)
//    }
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
            TextField("Enter title", text: $title)
                .textFieldStyle(.roundedBorder)
            Picker("Priority", selection: $selectedPriority) {
                ForEach(Priority.allCases) { priority in
                    Text(priority.title).tag(priority)
                }
            }
            .pickerStyle(.segmented)
                
                Button("Save") {
                    saveTask()
                }.padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
                
                List {
                    ForEach(allTasks) { task in
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
                            
                            
//                            Button(action: {
//                                    viewContex.delete(allTasks)!
//                                }, label: {
//                                    Image(systemName:  "trash")
//                             })
                            
                               // .contextMenu {
//                                    Button( action: {
//                                    viewContex(task)
//                                }) {
//                                    Image( systemImage: "trash")
//                                }.foregroundColor(Color.blue)
                            //}
                            
                            
//                            Button(action: {viewContex(task)}) {//.firstIndex(where: {$0.id == task.id})!)}) {
//                                Image(systemName: "trash")
//                            }.foregroundColor(Color.blue)
                            
                            
                        Text(task.title ?? "")
                            
                            Spacer()
                            Image(systemName: task.isFavorite ? "heart.fill" : "heart")
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
            .padding()
        .navigationTitle("All Tasks")
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
