//
//  TimerStateStoreDelegate.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
protocol TimerStoreDelegate{
    func observe(observer:TimerStoreObserver)
    func getKeys() -> [String]
    func getDueDate(fromKey:String) -> Date
    func getIsPaused(fromKey:String) -> Bool
    func getIsTimeup(fromKey:String) -> Bool
    func getRemainSec(fromKey: String) -> Int
    func remove(fromKey:String)
    func enqueue(fromKey:String, dueDate:Date, remainSec:Int)
    func changePause(fromKey:String)
    func changeTimeup(fromKey:String)
    func changeRemainSec(fromKey:String, remainSec:Int)
    
    func extract() -> TimerQueueRootState
    func load(state:TimerQueueRootState)
}

protocol TimerStoreObserver{
    func StateChanged(root:TimerQueueRootState)
}
