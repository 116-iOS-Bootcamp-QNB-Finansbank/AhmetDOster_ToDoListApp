//
//  ToDoListContracts.swift
//  ToDoListContracts
//
//  Created by T.A on 20.10.2021.
//

import Foundation
import UIKit

//MARK: ToDoListViewProtocol
protocol ToDoListViewProtocol: NSObject {
    func handleOutput(_ output: ToDoListPresenterOutput)
}

//MARK: ToDoListInteractorOutput
enum ToDoListInteractorOutput {
    case showToDoDetail(ToDoObj)
    case showToDoList([ToDoObj])
}

//MARK: ToDoListInteractorDelegate
protocol ToDoListInteractorDelegate: NSObject {
    func handleOutput(_ output: ToDoListInteractorOutput)
}

//MARK: ToDoListInteractorProtocol
protocol ToDoListInteractorProtocol: NSObject {
    var delegate: ToDoListInteractorDelegate? { get set }
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector)
}

//MARK: ToDoListPresenterProtocol
protocol ToDoListPresenterProtocol: NSObject {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector) 
}

//MARK: ToDoListPresenterOutput
enum ToDoListPresenterOutput {
    case showToDoList([ToDoListPresentation])
}

//MARK: ToDoListRoute
enum ToDoListRoute {
    case showToDoDetail(ToDoObj)
}

//MARK: ToDoListRouterProtocol
protocol ToDoListRouterProtocol: NSObject {
    func navigate(to route: ToDoListRoute)
}

