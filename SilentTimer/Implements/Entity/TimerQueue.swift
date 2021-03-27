//
//  TimerQueue.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
class TimerQueue : TimerStoreDelegate{

    
    var observers = [TimerStoreObserver]()
    var state:TimerQueueRootState
    init(){
        self.state = TimerQueueRootState()
    }
    
    func observe(observer: TimerStoreObserver) {
        observers.append(observer)
    }
    
    func getDueDate(fromKey: String) -> Date {
        for i in 0..<self.state.queue.count{
            if(self.state.queue[i].key == fromKey){
                return self.state.queue[i].dueDate
            }
        }
        
        return Date.init(timeIntervalSince1970: 0)
    }
    
    func getRemainSec(fromKey: String) -> Int{
        for i in 0..<self.state.queue.count{
            if(self.state.queue[i].key == fromKey){
                return self.state.queue[i].remainSec
            }
        }
        
        return -1
    }

    func getIsPaused(fromKey: String) -> Bool {
        for i in 0..<self.state.queue.count{
            if(self.state.queue[i].key == fromKey){
                return self.state.queue[i].isPaused
            }
        }
        
        return false
    }
    
    func getIsTimeup(fromKey: String) -> Bool{
        for i in 0..<self.state.queue.count{
            if(self.state.queue[i].key == fromKey){
                return self.state.queue[i].timeup
            }
        }
        return false
    }
    
    func getKeys() -> [String] {
        return Array(state.queue.map{$0.key})
    }
    
    func remove(fromKey: String) {
        let newState = state.remove(fromKey: fromKey)
        Update(root: newState)
    }
    
    func enqueue(fromKey: String, dueDate: Date, remainSec:Int) {
        let newState = state.enqueue(record: TimerRecordState(key: fromKey, dueDate: dueDate, remainSec: remainSec))
        Update(root: newState)
    }
    
    func changePause(fromKey: String) {
        Update(root: state.pause(fromKey: fromKey))
    }
    
    func changeTimeup(fromKey: String){
        Update(root: state.timeup(fromKey: fromKey))
    }
    
    func changeRemainSec(fromKey: String, remainSec: Int) {
        Update(root: state.changeRemainSec(fromKey:fromKey, remainSec:remainSec))
    }
   
    func extract() -> TimerQueueRootState {
        return self.state
    }
    
    func load(state: TimerQueueRootState) {
        Update(root: state)
    }
    
    private func Update(root:TimerQueueRootState)
    {
        if(self.state != root)
        {
            self.state = root
            for i in 0..<observers.count{
                observers[i].StateChanged(root:self.state)
            }
        }
    }
}
