//
//  ToDoListPresentation.swift
//  ToDoListPresentation
//
//  Created by T.A on 16.10.2021.
//

import Foundation

struct ToDoListPresentation {
    
    //MARK: Properties
    let id: String
    let title: String
    let completionDate: Date
    
    //MARK: func
    init(id: String, title: String, compeltionDate: Date) {
        self.id = id
        self.title = title
        self.completionDate = compeltionDate
    }
    
    init(toDo: ToDoObj) {
        self.init(id: toDo.id, title: toDo.title, compeltionDate: toDo.completionDate)
    }
}
