//
//  ToDoListInteractor.swift
//  ToDoListInteractor
//
//  Created by T.A on 20.10.2021.
//

import Foundation

class ToDoListInteractor: NSObject, ToDoListInteractorProtocol {
    weak var delegate: ToDoListInteractorDelegate?
    private let service: ToDoEntityManager
    private var toDos: [ToDoObj] = []
    
    init(service: ToDoEntityManager) {
        self.service = service
    }
    
    func viewDidLoad() {
        // send screen name event
        // logger.sendScreenName("ToDoList")
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
}
