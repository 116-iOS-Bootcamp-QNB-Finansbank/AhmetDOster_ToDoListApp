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
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init(toDo: TodoObject) {
        self.init(id: toDo.id, title: toDo.title)
    }
}
