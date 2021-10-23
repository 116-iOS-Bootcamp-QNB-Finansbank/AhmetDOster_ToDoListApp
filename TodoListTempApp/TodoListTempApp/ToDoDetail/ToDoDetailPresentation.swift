//
//  ToDoDetailPresentation.swift
//  ToDoDetailPresentation
//
//  Created by T.A on 16.10.2021.
//

import Foundation

struct ToDoDetailPresentation {
    
    //MARK: Properties
    let id: String
    let title: String
    let detail: String
    let completionDate: Date
    
    //MARK: init
    init(id: String, title: String, detail: String, completionDate: Date) {
        self.id = id
        self.title = title
        self.detail = detail
        self.completionDate = completionDate
    }
    
    init(title: String, detail: String, completionDate: Date)
    {
        self.id = UUID().uuidString
        self.title = title
        self.detail = detail
        self.completionDate = completionDate
    }
    
    init(toDo: ToDoObj!) {
        
        if let toDo = toDo
        {
            self.init(id: toDo.id, title: toDo.title, detail: toDo.detail, completionDate: toDo.completionDate)
        }
        else
        {
            self.init()
        }
    }
    
    init() {
        id = ""
        title = ""
        detail = ""
        completionDate = Date()
    }
}
