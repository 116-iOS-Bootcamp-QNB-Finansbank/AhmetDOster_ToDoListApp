//
//  ToDoListRouter.swift
//  ToDoListRouter
//
//  Created by T.A on 20.10.2021.
//

import UIKit

class ToDoListRouter: NSObject, ToDoListRouterProtocol {
    
    //MARK: Properties
    private unowned let view: UIViewController
    
    //MARK: init
    init(view: UIViewController) {
        self.view = view
    }
    
    //MARK: func
    func navigate(to route: ToDoListRoute) {
        switch route {
        case .showToDoDetail(let toDo):
            let viewController = ToDoDetailBuilder.build(with: toDo)
            self.view.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
