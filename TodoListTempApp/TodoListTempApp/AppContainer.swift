//
//  AppContainer.swift
//  AppContainer
//
//  Created by T.A on 17.10.2021.
//

import Foundation
import UIKit

let appContainer = AppContainer()

class AppContainer {
    let service = ToDoEntityManager()
    let router = AppRouter()
    let notificationManager = NotificationCenterManager()
}
