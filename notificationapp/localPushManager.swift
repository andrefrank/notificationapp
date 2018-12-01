//
//  localPushManager.swift
//  notificationapp
//
//  Created by Daniel Keglmeier on 30.11.18.
//  Copyright © 2018 Daniel Keglmeier. All rights reserved.
//

import Foundation
import UserNotifications

class LocalPushManager: NSObject {
    static var shared = LocalPushManager()
    let center = UNUserNotificationCenter.current()
    var skipp = false
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if error == nil {
                print("Granted")
            }
        }
    }
    
    func sendLocalPush(in time: TimeInterval) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "WakeUp", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Its time to cook", arguments: nil)
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        print("not skipped")
        center.add(request) { error in
            if error == nil {
                print("done")
            }
        }
        
//        var dataComponents = DateComponents()
//        dataComponents.hour = 19
//        dataComponents.minute = 41
        // let trigger2 = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
    }
}
