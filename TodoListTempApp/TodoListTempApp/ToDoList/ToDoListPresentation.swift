//
//  ToDoListPresentation.swift
//  ToDoListPresentation
//
//  Created by T.A on 16.10.2021.
//

import Foundation

struct ToDoListPresentation {
    
    let id: String
    let title: String
    let completionDate: Date
    
    init(id: String, title: String, compeltionDate: Date) {
        self.id = id
        self.title = title
        self.completionDate = compeltionDate
    }
    
    init(toDo: TodoObject) {
        self.init(id: toDo.id, title: toDo.title, compeltionDate: toDo.completionDate)
    }
}
