//
//  ToDoEntityManager.swift
//  ToDoEntityManager
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import CoreData

class ToDoEntityManager: ToDoEntityManagerProtocol{
    
    // MARK: - Public func
    func addToDo(toDo: ToDoObj!) -> Bool
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
            return true
        }
        
        return false
    }
    
    func updateToDo(toDo: ToDoObj!) -> Bool
    {
        if let toDo = toDo
        {
            let entity: ToDoEntity! = getToDoEntity(id: toDo.id)
            
            if let entity = entity
            {
                entity.title = toDo.title
                entity.detail = toDo.detail
                entity.completionDate = toDo.completionDate
                
                saveContext()
                return true
            }
        }
        
        return false
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
    
    // MARK: - Private func
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
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoListTempApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
