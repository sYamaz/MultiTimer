//
//  LocalNotificationCalenderTimer.swift
//  CupNoodlesMusicTimer
//
//  Created by 山﨑駿 on 2021/03/14.
//

import Foundation
import UserNotifications
class LocalNotificationCalenderTimer : RequestTimerDelegate
{
    @Injected var store:UserSettingStoreDelegate
    @Injected var queue:TimerStoreDelegate
    @Injected var alarm:AlarmDelegate
    
    func startTimer(waitForSeconds: Int) {
        let val = waitForSeconds
        
        // ローカル通知のの内容
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "ローカル通知テスト"
        content.subtitle = "タイマー通知"
        content.body = "タイマーによるローカル通知です"
                
        // ローカル通知実行日時をセット
        let date = Date()
        let timer:Double = Double(val)
        print("timer seconds : \(timer)")
        let newDate = Date(timeInterval: timer, since: date)
        let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)
                
        // ローカル通知リクエストを作成
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        // ユニークなIDを作る
        let identifier = NSUUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
        // ローカル通知リクエストを登録
        UNUserNotificationCenter.current().add(request){ (error : Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        queue.enqueue(fromKey: identifier, dueDate:newDate, remainSec: val)
    }
    
    func togglePause(keyFromQueue: String) {
        
    }
    
    func removeTimer(keyFromQueue: String) {
        /// 実行終了タイマー
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [keyFromQueue])
        queue.remove(fromKey: keyFromQueue)
    }
    
    func declement() -> Bool {
        /// 実行中タイマー
        UNUserNotificationCenter
            .current()
            .getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                    for request in requests {
                        print("identifier:\(request.identifier)")
                        print("  title:\(request.content.title)")
                        if request.trigger is UNCalendarNotificationTrigger {
                            let trigger = request.trigger as! UNCalendarNotificationTrigger
                            print("  <CalendarNotification>")
                            let components = DateComponents(calendar: Calendar.current, year: trigger.dateComponents.year, month: trigger.dateComponents.month, day: trigger.dateComponents.day, hour: trigger.dateComponents.hour, minute: trigger.dateComponents.minute)
                            print("    Scheduled Date:\(String(describing: components.date)))")
                            print("    Reperts:\(trigger.repeats)")
                        }
                        print("----------------")
                    }
                }
        
        /// 実行終了タイマー
        UNUserNotificationCenter
            .current()
            .getDeliveredNotifications { (notifications: [UNNotification]) in
                for notification in notifications {
                    print("identifier:\(notification.request.identifier)")
                    print("  title:\(notification.request.content.title)")

                    if notification.request.trigger is UNTimeIntervalNotificationTrigger {
                                        let trigger = notification.request.trigger as! UNTimeIntervalNotificationTrigger
                                        print("  <TimeIntervalNotification>")
                                        print("    TimeInterval:\(trigger.timeInterval)")
                                        print("    Reperts:\(trigger.repeats)")
                                    }
                    print("----------------")
                }
            }
        
        return false
    }
    
    
}
