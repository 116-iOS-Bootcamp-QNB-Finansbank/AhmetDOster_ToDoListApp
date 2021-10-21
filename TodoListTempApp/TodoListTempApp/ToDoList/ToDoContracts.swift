//
//  ToDoListContracts.swift
//  ToDoListContracts
//
//  Created by T.A on 20.10.2021.
//

import Foundation
import UIKit

//MARK: View
protocol ToDoListViewProtocol: NSObject {
    func handleOutput(_ output: ToDoListPresenterOutput)
}

//MARK: Interactor
enum ToDoListInteractorOutput {
    case showToDoDetail(ToDoObj)
    case showToDoList([ToDoObj])
}

protocol ToDoListInteractorDelegate: NSObject {
    func handleOutput(_ output: ToDoListInteractorOutput)
}

protocol ToDoListInteractorProtocol: NSObject {
    var delegate: ToDoListInteractorDelegate? { get set }
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector)
}

//MARK: Presenter
protocol ToDoListPresenterProtocol: NSObject {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector) 
}

enum ToDoListPresenterOutput {
    case showToDoList([ToDoListPresentation])
}

//MARK: Router
enum ToDoListRoute {
    case showToDoDetail(ToDoObj)
}

protocol ToDoListRouterProtocol: NSObject {
    func navigate(to route: ToDoListRoute)
}

