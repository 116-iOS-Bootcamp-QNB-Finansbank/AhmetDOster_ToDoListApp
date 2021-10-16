//
//  ToDoDetailPresentation.swift
//  ToDoDetailPresentation
//
//  Created by T.A on 16.10.2021.
//

import Foundation

struct ToDoDetailPresentation {
    
    let id: String
    let title: String
    let detail: String
    let completionDate: Date
    
    init(id: String, title: String, detail: String, completionDate: Date) {
        self.id = id
        self.title = title
        self.detail = detail
        self.completionDate = completionDate
    }
    
    init(toDo: TodoObject!) {
        self.init(id: toDo.id, title: toDo.title, detail: toDo.detail, completionDate: toDo.completionDate)
    }
    
    init() {
        id = ""
        title = ""
        detail = ""
        completionDate = Date()
    }
}
