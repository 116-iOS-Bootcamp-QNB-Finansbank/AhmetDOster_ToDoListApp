//
//  ToDoDetailBuilder.swift
//  ToDoDetailBuilder
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import UIKit

class ToDoDetailBuilder{
    
    //MARK: func
    static func build(with toDo: ToDoObj!) -> ToDoDetailViewController {
        
        let storyboard = UIStoryboard(name: "ToDoStoryBoard", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ToDoDetailViewController") as! ToDoDetailViewController
        
        viewController.viewModel = ToDoDetailViewModel(toDo: toDo)
        return viewController
    }
    
}
