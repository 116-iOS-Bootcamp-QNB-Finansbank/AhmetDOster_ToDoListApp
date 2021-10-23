//
//  NotificationCenterManager.swift
//  NotificationCenterManager
//
//  Created by T.A on 21.10.2021.
//

import Foundation
import UIKit

class NotificationCenterManager: NotificationCenterManagerProtocol {
    
    //MARK: Properties
    let notificationCenter: NotificationCenter
    
    //MARK: init
    init()
    {
        notificationCenter = NotificationCenter.default
    }
    
    //MARK: func
    func postNotification(name: Notification.Name)
    {
        notificationCenter.post(name: name, object: nil)
    }
    
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector) {
        
        notificationCenter.addObserver ( any , selector: selector, name: name, object: nil)
    }
}
