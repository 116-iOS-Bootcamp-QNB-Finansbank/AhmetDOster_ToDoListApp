//
//  ToDoDetailBuilder.swift
//  ToDoDetailBuilder
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import UIKit

class ToDoDetailBuilder{
    
    static func build(with toDo: ToDoListPresentation!) -> DetailViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        viewController.toDo=toDo
        
       // viewController.viewModel = MovieDetailViewModel(movie: movie)
        return viewController
    }
    
}
