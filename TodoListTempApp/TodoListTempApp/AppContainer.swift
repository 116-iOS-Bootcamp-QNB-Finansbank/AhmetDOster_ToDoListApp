//
//  AppContainer.swift
//  AppContainer
//
//  Created by T.A on 17.10.2021.
//

import Foundation

let appContainer = AppContainer()

class AppContainer {
    let service = ToDoEntityManager()
    let router = AppRouter()
}
