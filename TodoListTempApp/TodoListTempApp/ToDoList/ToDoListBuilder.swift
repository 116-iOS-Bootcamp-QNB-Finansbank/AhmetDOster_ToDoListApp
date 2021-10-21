//
//  ToDoListBuilder.swift
//  ToDoListBuilder
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import UIKit

class ToDoListBuilder{
    
    static func build() -> ToDoListViewController {
        
        let storyboard = UIStoryboard(name: "ToDoStoryBoard", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "ToDoListViewController") as! ToDoListViewController
        
        let interactor = ToDoListInteractor(service: appContainer.service)
        let router = ToDoListRouter(view: view)
        let presenter = ToDoListPresenter(interactor: interactor, view: view, router: router)
        
        view.presenter = presenter
        interactor.delegate = presenter
        return view
    }
    
}
