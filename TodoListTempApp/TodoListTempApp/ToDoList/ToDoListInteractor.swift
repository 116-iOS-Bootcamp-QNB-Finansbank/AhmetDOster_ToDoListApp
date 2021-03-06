//
//  ToDoListInteractor.swift
//  ToDoListInteractor
//
//  Created by T.A on 20.10.2021.
//

import Foundation
import UIKit

class ToDoListInteractor: NSObject, ToDoListInteractorProtocol {
    
    //MARK: Properties
    weak var delegate: ToDoListInteractorDelegate?
    private let service: ToDoEntityManager
    private var toDos: [ToDoObj] = []
    private let notificationManager: NotificationCenterManager
    
    //MARK: init
    init(service: ToDoEntityManager) {
        self.service = service
        self.notificationManager = appContainer.notificationManager
    }
    
    //MARK: func
    func viewDidLoad() {
        getToDos()
    }
    
    func getToDos() {
        self.toDos = service.getToDos()
        self.delegate?.handleOutput(.showToDoList(self.toDos))
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        self.delegate?.handleOutput(.showToDoDetail(toDo))
    }
    
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector) {
        notificationManager.addNotification(any: any, name: name, selector: selector)
    }
}
