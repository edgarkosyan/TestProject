//
//  NotificationManager.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    init() {
        requestPermission()
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if error == nil {
                if success {
                    print("Request Successed")
                    
                } else {
                    print("Request Failed")
                }
            } else {
                print("Err: \(String(describing: error))")
            }
        }
    }
    
    func scheduleNotification(pill: Pill) {
        let content = UNMutableNotificationContent()
        content.title = "Time to take your pill"
        content.subtitle = "It's time to take \(pill.name), Dose: \(pill.dose)"
        content.sound = UNNotificationSound.default
        
        let days = weekDays(weekDays: pill.days)
        
        for weekDay in days {
            var dateInfo = DateComponents()
            dateInfo.hour = pill.hour
            dateInfo.minute = pill.minute
            dateInfo.weekday = weekDay
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
            let request = UNNotificationRequest(identifier: pill.id + "\(weekDay)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func removeNotification(pill: Pill) {
        UNUserNotificationCenter.current().getPendingNotificationRequests {[weak self] (notificationRequests) in
            var identifiers: [String] = []
            
            for notification:UNNotificationRequest in notificationRequests {
                if let days = self?.weekDays(weekDays: pill.days) {
                    for day in days {
                        if notification.identifier == pill.id + "\(day)" {
                            identifiers.append(notification.identifier)
                           
                        }
                    }
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    func blabla(pill: Pill) {
        
        UNUserNotificationCenter.current().getPendingNotificationRequests {[weak self] (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if let days = self?.weekDays(weekDays: pill.days) {
                    for day in days {
                        if notification.identifier == pill.id + "\(day)" {
                            identifiers.append(notification.identifier)
                        }
                    }
                }
            }
        }
    }
    func weekDays(weekDays: [AddingViewModel.WeekDays]) -> [Int] {
        var days: [Int] = []
        for day in weekDays {
            switch day {
            case .sunday:
                days.append(1)
            case .monday:
                days.append(2)
            case .tuesday:
                days.append(3)
            case .wednesday:
                days.append(4)
            case .thursday:
                days.append(5)
            case .friday:
                days.append(6)
            case .saturday:
                days.append(7)
            }
        }
        return days
    }
}
