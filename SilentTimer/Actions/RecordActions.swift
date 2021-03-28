//
//  RecordActions.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/28.
//

import Foundation
import UserNotifications

extension TimerRecordRootState{
    func togglePause(predicate:(_:TimerRecordState) -> Bool) -> TimerRecordRootState{
        
        var items = self.records
        for i in items.indices{
            let old = items[i]
            if(predicate(old)){
                items[i] = old.togglePaused()
            }
        }
        return TimerRecordRootState(records:items)
    }
}

extension TimerRecordRootState{
    
    func delete(predicate:(_:TimerRecordState) -> Bool) -> TimerRecordRootState{
        let items = self.records.filter({(item) in return !predicate(item)})
        return TimerRecordRootState(records: items)
    }

}

extension TimerRecordRootState{
    
    func edit(predicate:(_:TimerRecordState) -> Bool, selector:(_:TimerRecordState)-> TimerRecordState) -> TimerRecordRootState{
        var items = self.records
        for i in items.indices{
            let old = items[i]
            if(predicate(old))
            {
                items[i] = selector(old)
            }
        }
        return TimerRecordRootState(records: items)
    }

}

extension TimerRecordRootState{
    
    func append(_  item:TimerRecordState) -> TimerRecordRootState{
        var newRecords = self.records
        newRecords.append(item)
        return TimerRecordRootState(records: newRecords)
    }
}

extension TimerRecordState{
    func sink(block:(_:TimerRecordState) -> Void){
        block(self)
    }
}

extension TimerRecordState{
    func togglePaused() -> TimerRecordState{
        let paused = self.isPaused
        return TimerRecordState(key: self.key, dueDate: self.dueDate, isPaused: !paused, timeup: self.timeup, remainSec: self.remainSec)
    }
}

extension TimerRecordState{
    func changeRemainSec(_ remain:Int) -> TimerRecordState{
        return TimerRecordState(key: self.key, dueDate: self.dueDate, isPaused: self.isPaused, timeup: self.timeup, remainSec: remain)
    }

}

extension TimerRecordState{
    func setTimeup() -> TimerRecordState{
        return TimerRecordState(key: self.key, dueDate: self.dueDate, isPaused: self.isPaused, timeup: true, remainSec: self.remainSec)
    }
}

extension TimerRecordState{
    func toNotificationRequest(title:String, subtitle:String, body:String) -> UNNotificationRequest{
        // ローカル通知のの内容
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = title
        content.subtitle = subtitle
        content.body = body
        
        // ローカル通知リクエストを作成
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.remainSec), repeats: false)
        let identifier = self.key
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
}

extension Array where Element == TimerRecordState{
    func toRoot() -> TimerRecordRootState{
        return TimerRecordRootState(records: self)
    }
}
