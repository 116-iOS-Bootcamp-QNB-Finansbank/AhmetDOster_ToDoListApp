//
//  ToDoEntityManager.swift
//  ToDoEntityManager
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import CoreData

class ToDoEntityManager{
    
    func addToDo(toDo: ToDoObj!)
    {
        if let toDo = toDo
        {
            let context = persistentContainer.viewContext
            let entity = ToDoEntity(context: context)
            entity.iD = toDo.id
            entity.title = toDo.title
            entity.detail = toDo.detail
            entity.completionDate = toDo.completionDate
            
            saveContext()
        }
        else { return}
        
    }
    
    func updateToDo(toDo: ToDoObj!)
    {
        if let toDo = toDo
        {
            let context = persistentContainer.viewContext
            let entity: ToDoEntity! = getToDoEntity(id: toDo.id)
            
            if let entity = entity
            {
                entity.title = toDo.title
                entity.detail = toDo.detail
                entity.completionDate = toDo.completionDate
                
                saveContext()
            }
        }
        else { return}
        
    }
    
    func getToDoEntity(id : String) -> ToDoEntity!
    {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        do {
            let context = persistentContainer.viewContext
            
            var entities: [ToDoEntity] = []
            
            entities = try context.fetch(fetchRequest)
            
            for entity in entities {
                
                if entity.iD == id
                {
                    return entity
                }
            }
            
        } catch {
            //handle error
        }
       
        return nil
    }
    
    func getToDoEntity(id : String) -> ToDoObj!
    {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        do {
            let context = persistentContainer.viewContext
            
            var entities: [ToDoEntity] = []
            
            entities = try context.fetch(fetchRequest)
            
            for entity in entities {
                
                if entity.iD == id
                {
                    
                    return ToDoObj(id: entity.iD!, title: entity.title!, detail: entity.detail!, completionDate: entity.completionDate ?? Date() )
                }
            }
            
        } catch {
            //handle error
        }
       
        return nil
    }
    
    func getToDos() ->[ToDoObj]! {
        
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        do {
            let context = persistentContainer.viewContext
            
            var toDoObjects: [ToDoObj] = []
            var entities: [ToDoEntity] = []
            
            entities = try context.fetch(fetchRequest)
            
            for entity in entities {
                
                toDoObjects.append(ToDoObj(id: entity.iD!, title: entity.title! , detail: entity.detail! , completionDate: entity.completionDate!))
            }
            
            return toDoObjects
            
        } catch {
            //handle error
        }
       
        return nil
    }
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TodoListTempApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
