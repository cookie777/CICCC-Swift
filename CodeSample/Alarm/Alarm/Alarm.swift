//
//  Alarm.swift
//  Alarm
//
//  Created by Derrick Park on 2021-02-10.
//  Copyright © 2021 AppDev Training. All rights reserved.
//

import Foundation
import UserNotifications

struct Alarm: Codable {
  // You want to track these identifiers to unschedule notifications if the user turns off the alarm
  private var notificationId: String
    
  var date: Date
  
  init(date: Date, notificationId: String? = nil) {
    self.date = date
    self.notificationId = notificationId ?? UUID().uuidString
  }
  
  func schedule(completion: @escaping (Bool) -> ()) {
    authorizeIfNeeded { (granted) in
      guard granted else {
        // Because the authorization might occur in the background, make this call on the main thread
        DispatchQueue.main.async {
          completion(false)
        }
        return
      }
      
      let content = UNMutableNotificationContent()
      content.title = "Alarm"
      content.body = "Beep Beep"
      content.sound = UNNotificationSound.default
      content.categoryIdentifier = Alarm.notificationCategoryId
      
      let triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self.date)
      let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
      
      let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request) { (error: Error?) in
        DispatchQueue.main.async {
          if let error = error {
            print(error.localizedDescription)
            completion(false)
          } else {
            Alarm.scheduled = self
            completion(true)
          }
        }
      }
    }
  }
  
  func unschedule() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
    Alarm.scheduled = nil
  }
  
  private func authorizeIfNeeded(completion: @escaping (Bool) -> ()) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.getNotificationSettings { (settings) in
      switch settings.authorizationStatus {
      case .authorized:
        completion(true)
      case .notDetermined:
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, _) in
          completion(granted)
        }
      default: // provisional, denied, ...
        completion(false)
      }
    }
  }
  
}

extension Alarm {
  static let notificationCategoryId = "AlarmNotification"
  static let snoozeActionId = "snooze"
  
  private static let alarmURL: URL = {
    guard let baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      fatalError("Can't get URL for documents directory")
    }
    return baseURL.appendingPathComponent("ScheduledAlarm")
  }()
  
  static var scheduled: Alarm? {
    get {
      guard let data = try? Data(contentsOf: alarmURL) else { return nil }
      return try? JSONDecoder().decode(Alarm.self, from: data)
    }
    set (newValue) {
      if let alarm = newValue {
        let data = try? JSONEncoder().encode(alarm)
        try? data?.write(to: alarmURL)
      } else {
        // when scheduled is set to nil, remove any data stored at alarmURL
        try? FileManager.default.removeItem(at: alarmURL)
      }
      // Use NotificationCenter when your model(observable) wants to talk to some controller (observer) (NotifcationCenter & KVO)
      NotificationCenter.default.post(name: .alarmUpdated, object: nil)
    }
  }
}


