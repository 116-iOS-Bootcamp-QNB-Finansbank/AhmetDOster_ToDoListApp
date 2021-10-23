//
//  UserNotificationCenterManager.swift
//  UserNotificationCenterManager
//
//  Created by T.A on 22.10.2021.
//

import Foundation
import UserNotifications

class UserNotificationCenterManager: UserNotificationCenterManagerProtocol {
    
    //MARK: Properties
    let userNotificationCenter: UNUserNotificationCenter
    
    //MARK: init
    init()
    {
        userNotificationCenter = UNUserNotificationCenter.current()
    }
    
    //MARK: func
    func requestAuthorization() -> Bool
    {
        var isAuthorization: Bool = false
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge])  {
            (success, error) in
            // success: kullanıcı izin verdiyse true, vermediyse false
            //error: kullanıcı izin verdiyse nil, vermediyse bu error hatanın nedenini anlatır
            
            if error != nil {
                //Bir hata meydana geldi
                print(error!)
            }
            else {
                // Kullanıcıdan izin alındı
            }
            
            isAuthorization = success
        }
        
        return isAuthorization
        
    }
    
    
    //Notification varsa update yoksa ekler
    func addUserLocalNotification(identifier: String, title: String, subTitle: String, body: String, triggerDate: Date)
    {
        
        //Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        
        //10 snlik bir gecikmeyi ifade eder.
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 50, repeats: false)
        
        // Şimdiki zamana 1 saat ekler
        //let date = Date(timeIntervalSinceNow: 3600)
        
        //Trigger with date
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: triggerDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //Add Local Notification
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    // Kayıtlı notificationları döner
    func getNotificationList()  -> [UNNotificationRequest]
    {
        let group = DispatchGroup()
        group.enter()
        
        var notifications: [UNNotificationRequest] = []
        
        userNotificationCenter.getPendingNotificationRequests(completionHandler: {requests -> () in
            notifications = requests
            group.leave()
        })
        
        group.wait()
        
        /*
         print("\(notifications.count) requests -------")
         for notification in notifications{
         print(notification.identifier)
         let trigger = notification.trigger
         print(trigger)
         }
         */
        
        return notifications
    }
    
}
