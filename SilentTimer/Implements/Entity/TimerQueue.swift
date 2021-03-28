//
//  TimerQueue.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
import Combine
class TimerQueue : TimerStoreDelegate{

    
    var observers = Dictionary<UUID, TimerStoreObserver>()
    var state:TimerRecordRootState
    init(){
        self.state = TimerRecordRootState()
    }
    
    func observe(id:UUID, observer: TimerStoreObserver) {
        observers.updateValue(observer, forKey: id)
    }
    
    func getDueDate(fromKey: String) -> Date {
        for i in 0..<self.state.records.count{
            if(self.state.records[i].key == fromKey){
                return self.state.records[i].dueDate
            }
        }
        
        return Date.init(timeIntervalSince1970: 0)
    }
    
    func getRemainSec(fromKey: String) -> Int{
        for i in 0..<self.state.records.count{
            if(self.state.records[i].key == fromKey){
                return self.state.records[i].remainSec
            }
        }
        
        return -1
    }

    func getIsPaused(fromKey: String) -> Bool {
        for i in 0..<self.state.records.count{
            if(self.state.records[i].key == fromKey){
                return self.state.records[i].isPaused
            }
        }
        
        return false
    }
    
    func getIsTimeup(fromKey: String) -> Bool{
        for i in 0..<self.state.records.count{
            if(self.state.records[i].key == fromKey){
                return self.state.records[i].timeup
            }
        }
        return false
    }
    
    func getKeys() -> [String] {
        return Array(state.records.map{$0.key})
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
   
    func extract() -> TimerRecordRootState {
        return self.state
    }
    
    func load(state: TimerRecordRootState) {
        Update(root: state)
    }
    
    private func Update(root:TimerRecordRootState)
    {
        if(self.state != root)
        {
            self.state = root
            for key in observers.keys{
                observers[key]?.StateChanged(root: self.state)
            }
        }
    }
}
