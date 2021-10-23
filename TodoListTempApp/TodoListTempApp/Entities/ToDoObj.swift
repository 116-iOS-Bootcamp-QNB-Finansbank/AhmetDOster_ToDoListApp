//
//  ToDoObj.swift
//  ToDoObj
//
//  Created by T.A on 16.10.2021.
//

import Foundation

class ToDoObj{
    
    //MARK: Properties
    let id: String
    var title: String
    var detail: String
    var completionDate: Date
    
    //MARK: init
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
