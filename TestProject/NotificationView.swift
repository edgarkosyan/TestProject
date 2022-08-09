//
//  NotificationView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    var body: some View {
        VStack {
            Button {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    
                }
            } label: {
                Text("Request Permission")
            }
            
            Button {
                request()
            } label: {
                Text("Request scheduled notification")
            }

        }

    }
    
    func request() {
        let content = UNMutableNotificationContent()
        content.title = "Medicines"
        content.subtitle = "Korvalol"
        content.sound = UNNotificationSound.default
        var datacom = DateComponents()
        datacom.weekdayOrdinal = 1234
        //var a = UNTimeIntervalNotificationTrigger(
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
