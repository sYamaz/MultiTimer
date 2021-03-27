//
//  LocalNotificationIntervalTimer.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation
import UserNotifications
class LocalNotificationIntervalTimer : RequestTimerDelegate
{
    @Injected var queue:TimerStoreDelegate

    func startTimer(waitForSeconds: Int) {
        let val = waitForSeconds
        let now = Date()
        let dueDate = Date(timeInterval:Double(val), since: now)
        // ローカル通知のの内容
        let content = UNMutableNotificationContent()
        //content.sound = .default
        content.title = "ローカル通知テスト"
        content.subtitle = "タイマー通知"
        content.body = "タイマーによるローカル通知です"
        
        content.sound = .default

        // タイマーの時間（秒）をセット
        let timer = val
        // ローカル通知リクエストを作成
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timer), repeats: false)
        let identifier = NSUUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter
            .current()
            .add(request)
            { (error : Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        
        queue.enqueue(fromKey: identifier, dueDate: dueDate, remainSec: val)
    }
    
    func togglePause(keyFromQueue: String) {
    
        
        if(queue.getIsPaused(fromKey: keyFromQueue))
        {
            // 再開処理
            let val = queue.getRemainSec(fromKey: keyFromQueue)
            
            startTimer(waitForSeconds: val)
            
            // 古いタイマーインスタンスを削除
            self.removeTimer(keyFromQueue: keyFromQueue)
        }
        else
        {
            self.queue.changePause(fromKey: keyFromQueue)
            // 通知センターから削除
            UNUserNotificationCenter
                .current()
                .removePendingNotificationRequests(withIdentifiers: [keyFromQueue])
            
        }
    }
    
    func removeTimer(keyFromQueue: String) {
        
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: [keyFromQueue])
        
        queue.remove(fromKey: keyFromQueue)
    }
    
    func declement(count:Int) -> Bool {
        print("declement")
        
        let now = Date()
        
        /// 実行中タイマー
        UNUserNotificationCenter
            .current()
            .getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    if(self.queue.getIsTimeup(fromKey: request.identifier) == false){
                        if(self.queue.getIsPaused(fromKey: request.identifier) == false) {
                            let dueDate = self.queue.getDueDate(fromKey: request.identifier)
                            let newRemainSec = Int(now.distance(to: dueDate))
                            self.queue.changeRemainSec(fromKey: request.identifier, remainSec:newRemainSec)
                        }
                    }
                }
            }
        
        /// 終了したタイマーのステータスを変更する
        UNUserNotificationCenter
            .current()
            .getDeliveredNotifications { (notifications: [UNNotification]) in
                for notification in notifications {
                    self.queue.changeTimeup(fromKey: notification.request.identifier)
                }
            }
        
        
        return false
    }
}
