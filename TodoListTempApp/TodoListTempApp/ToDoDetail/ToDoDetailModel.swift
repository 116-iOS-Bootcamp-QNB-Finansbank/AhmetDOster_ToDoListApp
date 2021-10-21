//
//  ToDoDetailModel.swift
//  ToDoDetailModel
//
//  Created by T.A on 16.10.2021.
//

import Foundation


class ToDoDetailViewModel: ToDoDetailViewModelProtocol {
    
    weak var delegate: ToDoDetailViewModelDelegate?
    
    private var toDo: ToDoObj
    private let service: ToDoEntityManager
    
    init(toDo: ToDoObj) {
        self.toDo = toDo
        self.service = appContainer.service
    }
    
    func viewDidLoad() {
        delegate?.showMovieDetail(ToDoDetailPresentation(toDo: toDo))
    }
    
    
    /*
    func getToDo(id: String) -> ToDoDetailPresentation
    {
        var toDoObject: ToDoObj! = service.getToDoEntity(id: id)
        
        toDo=ToDoDetailPresentation(toDo: toDoObject)
        
        return toDo
    }
     */
    
    func updateToDo(toDoDetail: ToDoDetailPresentation){
        
        service.updateToDo(toDo: ToDoObj(id: toDoDetail.id, title: toDoDetail.title, detail: toDoDetail.detail, completionDate: toDoDetail.completionDate))
    }
    
    func addToDo(toDoDetail: ToDoDetailPresentation){
        
        service.addToDo(toDo: ToDoObj(id: toDoDetail.id, title: toDoDetail.title, detail: toDoDetail.detail, completionDate: toDoDetail.completionDate))
    }
    
    
}


