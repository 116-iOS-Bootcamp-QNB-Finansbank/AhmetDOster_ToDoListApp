//
//  ToDoListPresenter.swift
//  ToDoListPresenter
//
//  Created by T.A on 20.10.2021.
//

import Foundation

class ToDoListPresenter: NSObject, ToDoListPresenterProtocol {
    private unowned let view: ToDoListViewProtocol
    private let router: ToDoListRouterProtocol
    private var interactor: ToDoListInteractorProtocol
    
    init(interactor: ToDoListInteractorProtocol,
         view: ToDoListViewProtocol,
         router: ToDoListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
}

extension ToDoListPresenter: ToDoListInteractorDelegate {
    func handleOutput(_ output: ToDoListInteractorOutput) {
        switch output {
        case .showToDoList(let toDos):
            view.handleOutput(.showToDoList(toDos.map(ToDoListPresentation.init)))
        case .showToDoDetail(let toDo):
            router.navigate(to: .showToDoDetail(toDo))
        }
    }
}
