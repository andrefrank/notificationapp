//
//  localPushManager.swift
//  notificationapp
//
//  Created by Daniel Keglmeier on 30.11.18.
//  Copyright © 2018 Daniel Keglmeier. All rights reserved.
//

//01.12.2018 Changed to UIKit to support access to UIApplication
import UIKit
import UserNotifications

class LocalPushManager: NSObject {
    static var shared = LocalPushManager()
    let center = UNUserNotificationCenter.current()
    
    private var _backingSkip:Bool=false
    //Update: It seems that local values will not persist through background mode therefore this seems to be buggy....
    var skipp:Bool{
        set{
            _backingSkip=newValue
        }
        get{return _backingSkip}
    }
    
    
    /// Usernotification timer
    let time=TimeInterval(10)
    /// This property configures the UserNotification event for  a new show
    ///
    
    /**
     Returns: An UNNotificationRequest for a single shot notification
     */
    var newShowAvailableRequest:UNNotificationRequest{
        //Remove all existing Notifications before adding a new one
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats:false)
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "WakeUp", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Its time to cook", arguments: nil)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        return request
    }
    
    
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if error == nil {
                print("Granted")
            }
        }
    }
    
    func backgroundMode_Fetch(enable:Bool=true){
        if enable{
            UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        }else{
            UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalNever)
            //Remove all existing Notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    //This method will be called from IOS when approbiate
    func background_Fetch(fetched:Bool){
        //Do something within 30 seconds before IOS blocks the call
        
        if _backingSkip{
            center.add(self.newShowAvailableRequest) { (error) in
                if error==nil{
                    print("Notification request added")
                }
            }
        }else{
            print("No shows available")
        }
        
    }
    

    func sendLocalPush(in time: TimeInterval) {
       
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats:true)
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
