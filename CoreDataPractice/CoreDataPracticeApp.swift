//
//  CoreDataPracticeApp.swift
//  CoreDataPractice
//
//  Created by Jannatun Nahar Papia on 11/6/22.
//

import SwiftUI

@main
struct CoreDataPracticeApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
