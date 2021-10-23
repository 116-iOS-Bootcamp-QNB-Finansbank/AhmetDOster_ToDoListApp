//
//  ToDoDetailContracts.swift
//  ToDoDetailContracts
//
//  Created by T.A on 21.10.2021.
//

import Foundation

//MARK: ToDoDetailViewModelDelegate
protocol ToDoDetailViewModelDelegate: NSObject {
    func showMovieDetail(_ todo: ToDoDetailPresentation)
}

//MARK: ToDoDetailViewModelProtocol
protocol ToDoDetailViewModelProtocol {
    var delegate: ToDoDetailViewModelDelegate? { get set }
    func viewDidLoad()
    func updateToDo(toDoDetail: ToDoDetailPresentation)
    func addToDo(toDoDetail: ToDoDetailPresentation)
    func postNotification(name: Notification.Name)
}
