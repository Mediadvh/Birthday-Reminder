//
//  UserPermission.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 2/7/1400 AP.
//

import Foundation
import UserNotifications

class LocalNotifications{
    
   
    func makeNotification(with message: String,with body: String, with date: Date){
       
        //Step 1: Ask for permission
         let center = UNUserNotificationCenter.current()
            
        center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
                print("granted permission")
                
                
        }
       
        //Step 2: Create notification content
        let content = UNMutableNotificationContent()
        
        
        //Step 3:scheduleNotification
        
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        content.title = message
        content.body = body
        
    
        // step 4: Create the request
   
        let uuidString = UUID().uuidString
    
        let request = UNNotificationRequest(identifier: uuidString , content: content, trigger: trigger)
        
    
        //Step 5: Register the request
        center.add(request) { (error) in
          // handle the error
        }
    }
}
