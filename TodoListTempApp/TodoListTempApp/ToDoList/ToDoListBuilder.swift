//
//  ToDoListBuilder.swift
//  ToDoListBuilder
//
//  Created by T.A on 16.10.2021.
//

import Foundation
import UIKit

class ToDoListBuilder{
    
    static func build() -> ViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        
        return viewController
    }
    
}
