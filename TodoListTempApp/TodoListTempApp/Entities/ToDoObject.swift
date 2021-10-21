//
//  ToDoObject.swift
//  ToDoObject
//
//  Created by T.A on 16.10.2021.
//

import Foundation

struct TodoObject{
    
    let id: String
    var title: String
    var detail: String
    var completionDate: Date
    
    
    init(id: String, title: String, detail: String, completionDate: Date)
    {
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
    
}
