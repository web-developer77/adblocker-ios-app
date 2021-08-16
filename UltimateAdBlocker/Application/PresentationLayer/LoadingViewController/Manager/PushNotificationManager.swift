//
//  PushNotificationManager.swift
//  FVBlocker
//
//  Created by Macintosh on 05.11.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import Foundation
import UIKit

class PushNotificationManager: NSObject {
    
    // - Shared
    static let shared = PushNotificationManager()
    
    // - Manager
    private let notificationCenter = UNUserNotificationCenter.current()
        
    func set(pushes: [PushModel]) {
        resetAllPushNotifications()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (_, _) in
            self?.scheduleNotifications(pushes: pushes)
        }
    }
    
    func resetAllPushNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
}

// MARK: -
// MARK: - Create local notifications

private extension PushNotificationManager {
    
    func scheduleNotifications(pushes: [PushModel]) {
        for push in pushes {
            let startTimeInterval = Double(push.startInterval)
            for index in 1...push.count {
                let timeInterval = startTimeInterval + Double(push.timeInterval * index)
                createNotification(title: push.title, message: push.text, timeInterval: timeInterval)
            }
        }
    }
    
    private func createNotification(title: String, message: String, timeInterval: Double) {
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: "\(timeInterval)", content: content, trigger: trigger)
        
        print(title, message, timeInterval)
        
        notificationCenter.add(request) { (error) in }
    }
    
}

