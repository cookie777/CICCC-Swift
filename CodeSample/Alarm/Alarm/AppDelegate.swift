//
//  AppDelegate.swift
//  Alarm
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let center = UNUserNotificationCenter.current()
    
    let snoozeAction = UNNotificationAction(identifier: Alarm.snoozeActionId, title: "Snooze", options: [])
    let alarmCategory = UNNotificationCategory(identifier: Alarm.notificationCategoryId, actions: [snoozeAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([alarmCategory])
    center.delegate = self
    
    return true
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // when user tap the snooze action button, create a new alarm object (extend 5 mins)
    if response.actionIdentifier == Alarm.snoozeActionId {
      let snoozeDate = Date().addingTimeInterval(1 * 60) // add 5 mins
      let alarm = Alarm(date: snoozeDate)
      alarm.schedule { (granted) in
        if !granted {
          print("Can't schedule snooze because notification permissions were revoked.")
        }
      }
    }
    // DO NOT FORGET!
    completionHandler()
  }
  // By default, when in foreground, notification X.
  // Modify the default behaviour! -> notification when in the foreground as well! - alarm!
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    completionHandler([.alert, .sound])
    // since the notification is about to be presented so users should be able to schedule a new alarm right away
    Alarm.scheduled = nil
  }
}

