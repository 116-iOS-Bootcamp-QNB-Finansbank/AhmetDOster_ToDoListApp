//
//  ToDoDetailModel.swift
//  ToDoDetailModel
//
//  Created by T.A on 16.10.2021.
//

import Foundation


class ToDoDetailViewModel: ToDoDetailViewModelProtocol {
    
    weak var delegate: ToDoDetailViewModelDelegate?
    
    private var toDo: ToDoObj!
    private let service: ToDoEntityManager
    private let notificationManager: NotificationCenterManager
    
    init(toDo: ToDoObj!) {
        self.toDo = toDo
        self.service = appContainer.service
        self.notificationManager = appContainer.notificationManager
    }
    
    func viewDidLoad() {
        delegate?.showMovieDetail(ToDoDetailPresentation(toDo: toDo))
    }
    
    func updateToDo(toDoDetail: ToDoDetailPresentation){
        
        service.updateToDo(toDo: ToDoObj(id: toDoDetail.id, title: toDoDetail.title, detail: toDoDetail.detail, completionDate: toDoDetail.completionDate))
    }
    
    func addToDo(toDoDetail: ToDoDetailPresentation){
        
        service.addToDo(toDo: ToDoObj(id: toDoDetail.id, title: toDoDetail.title, detail: toDoDetail.detail, completionDate: toDoDetail.completionDate))
    }
    
    func postNotification(name: Notification.Name)
    {
        notificationManager.postNotification(name: name)
    }
}


