//
//  ToDoListViewModel.swift
//  ToDoListViewModel
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import UIKit

class ToDoListViewModel {
    
    //MARK: Properties
    private let service: ToDoEntityManager
    private var toDos: [ToDoObj]! = []
    
    //MARK: ToDoListViewProtocol
    init() {
        self.service = appContainer.service
    }
    
    //MARK: func
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
