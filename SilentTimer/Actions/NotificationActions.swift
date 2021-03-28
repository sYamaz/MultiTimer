//
//  NotificationActions.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/28.
//

import Foundation
import UserNotifications
extension UNNotificationRequest{
    func send(){
        UNUserNotificationCenter
            .current()
            .add(self) { (error : Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
}


typealias NotificationIdentifier = String
extension NotificationIdentifier{
    func deleteFromPendingStore() -> NotificationIdentifier{
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: [self])
        return self
    }
}

extension NotificationIdentifier{
    static func sinkDeliveredIdentifiers(_ closure: @escaping (_ :[NotificationIdentifier]) -> Void){
        UNUserNotificationCenter
            .current()
            .getDeliveredNotifications { (notifications: [UNNotification]) in
                closure(notifications.map({n in n.request.identifier}))
            }
        
    }
}

extension NotificationIdentifier{
    static func sinkPendingIdentifiers(_ closure: @escaping (_ :[NotificationIdentifier]) -> Void){
        UNUserNotificationCenter
            .current()
            .getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                closure(requests.map({r in r.identifier}))
            }
    }
}
