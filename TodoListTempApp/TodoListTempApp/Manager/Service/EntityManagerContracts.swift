//
//  EntityManagerContracts.swift
//  EntityManagerContracts
//
//  Created by T.A on 23.10.2021.
//

import Foundation
import CoreData

//MARK: ToDoEntityManagerProtocol
protocol ToDoEntityManagerProtocol {
    func addToDo(toDo: ToDoObj!) -> Bool
    func updateToDo(toDo: ToDoObj!) -> Bool
    func getToDoEntity(id : String) -> ToDoEntity!
    func getToDos() ->[ToDoObj]!
    func getToDoEntity(id : String) -> ToDoObj!
    func saveContext ()
    var persistentContainer: NSPersistentContainer { get set }
}
