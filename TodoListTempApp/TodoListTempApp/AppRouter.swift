//
//  Router.swift
//  Router
//
//  Created by T.A on 16.10.2021.
//

import UIKit

class AppRouter {
    
    func start(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ToDoListBuilder.build())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
