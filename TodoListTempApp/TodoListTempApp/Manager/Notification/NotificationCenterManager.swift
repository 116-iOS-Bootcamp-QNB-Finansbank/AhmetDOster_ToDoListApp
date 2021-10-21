//
//  NotificationCenterManager.swift
//  NotificationCenterManager
//
//  Created by T.A on 21.10.2021.
//

import Foundation
import UIKit

class NotificationCenterManager {
    
    let notificationCenter: NotificationCenter
    
    init()
    {
        notificationCenter = NotificationCenter.default
    }
    
    func postNotification(name: Notification.Name)
    {
        notificationCenter.post(name: name, object: nil)
    }
    
    func addNotification(any: UIViewController, name: Notification.Name, selector: Selector) {
        
        notificationCenter.addObserver ( any , selector: selector, name: name, object: nil)
    }
}
