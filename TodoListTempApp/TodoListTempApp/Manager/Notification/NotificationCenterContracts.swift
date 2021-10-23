//
//  NotificationCenterContracts.swift
//  NotificationCenterContracts
//
//  Created by T.A on 23.10.2021.
//

import Foundation
import UIKit
import UserNotifications

//MARK: NotificationCenterManagerProtocol
protocol NotificationCenterManagerProtocol {
    func postNotification(name: Notification.Name)
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector)
}

//MARK: UserNotificationCenterManagerProtocol
protocol UserNotificationCenterManagerProtocol {
    func requestAuthorization() -> Bool
    func addUserLocalNotification(identifier: String, title: String, subTitle: String, body: String, triggerDate: Date)
    func getNotificationList()  -> [UNNotificationRequest]
}
