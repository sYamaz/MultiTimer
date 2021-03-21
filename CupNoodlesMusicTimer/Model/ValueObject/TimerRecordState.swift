//
//  TimerRecordState.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
// Keep Immutable
extension TimerRecordState : Codable{}
struct TimerRecordState : Equatable{
    let key:String
    let dueDate:Date
    let isPaused:Bool
    let timeup:Bool
    let remainSec:Int
    
    init(key:String, dueDate:Date, remainSec:Int) {
        self.key = key
        self.dueDate = dueDate
        self.isPaused = false
        self.timeup = false
        self.remainSec = remainSec
    }
    
    private init(key:String, dueDate:Date, remainSec:Int, isPaused:Bool, timeup:Bool) {
        self.key = key
        self.dueDate = dueDate
        self.isPaused = isPaused
        self.timeup = timeup
        self.remainSec = remainSec
    }
       
    func changePaused(isPaused:Bool) -> TimerRecordState{
        let ret = TimerRecordState(key: self.key, dueDate: self.dueDate, remainSec:self.remainSec, isPaused: !self.isPaused, timeup:self.timeup)
        return ret
    }
    
    func changeTimeup(isTimeup:Bool) -> TimerRecordState{
        let ret = TimerRecordState(key: self.key, dueDate: self.dueDate, remainSec:self.remainSec, isPaused: self.isPaused, timeup: isTimeup)
        return ret
    }
    
    func changeRemainSec(remainSec:Int) -> TimerRecordState{
        let ret = TimerRecordState(key: self.key, dueDate: self.dueDate, remainSec: remainSec, isPaused: self.isPaused, timeup: self.timeup)
        return ret
    }
}
