//
//  AppContainer.swift
//  AppContainer
//
//  Created by T.A on 17.10.2021.
//

import Foundation
import UIKit

//MARK: Properties
let appContainer = AppContainer()

class AppContainer {
    
    //MARK: Properties
    let service = ToDoEntityManager()
    let router = AppRouter()
    let notificationManager = NotificationCenterManager()
    let userNotificationManager = UserNotificationCenterManager()
}
