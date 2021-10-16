//
//  ToDoListViewModel.swift
//  ToDoListViewModel
//
//  Created by T.A on 16.10.2021.
//

import Foundation

class ToDoListViewModel {
    private let service: ToDoEntityManager
    private var toDos: [TodoObject]! = []
    
    init() {
        self.service = appContainer.service
    }
    
    
    func getToDos() -> [ToDoListPresentation]! {
        toDos = service.getToDos()
        
        if let  toDos =  toDos
        {
            var presententationList : [ToDoListPresentation] = []
            for toDo in toDos {
                
                presententationList.append(ToDoListPresentation(toDo: toDo))
            }
            
            return presententationList
        }
        return nil
    }
}
