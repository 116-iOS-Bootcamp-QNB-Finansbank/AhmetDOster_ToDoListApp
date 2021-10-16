//
//  ToDoDetailModel.swift
//  ToDoDetailModel
//
//  Created by T.A on 16.10.2021.
//

import Foundation

class ToDoDetailViewModel {
    private let service: ToDoEntityManager
    private var toDo: ToDoDetailPresentation
    
    init() {
        self.service = appContainer.service
        self.toDo = ToDoDetailPresentation()
    }
    
    func getToDo(id: String) -> ToDoDetailPresentation
    {
        var toDoObject: TodoObject! = service.getToDoEntity(id: id)
        
        toDo=ToDoDetailPresentation(toDo: toDoObject)
        
        return toDo
    }
    
    func updateToDo(toDo: ToDoDetailPresentation){
        
        service.updateToDo(toDo: TodoObject(id: toDo.id, title: toDo.title, detail: toDo.detail, completionDate: toDo.completionDate))
    }
    
    func addToDo(toDo: ToDoDetailPresentation){
        
        service.addToDo(toDo: TodoObject(id: toDo.id, title: toDo.title, detail: toDo.detail, completionDate: toDo.completionDate))
    }
    
}


