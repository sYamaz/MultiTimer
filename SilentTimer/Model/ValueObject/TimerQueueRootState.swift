//
//  TimerQueueRootState.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
// Keep Immutable
extension TimerQueueRootState : Codable{}
struct TimerQueueRootState : Equatable{
    var queue:[TimerRecordState]
    
    init() {
        self.queue = [TimerRecordState]()
    }
    
    private init(queue:[TimerRecordState]) {
        self.queue = queue
    }
    
    func enqueue(record:TimerRecordState) -> TimerQueueRootState{
        
        var newQueue = queue
        newQueue.append(record)
        
        return TimerQueueRootState(queue: newQueue)
    }
    
    func remove(fromKey:String) -> TimerQueueRootState{
        var newQueue = queue
        
        let maybeIndex = newQueue.firstIndex(where: {$0.key == fromKey })
        if(maybeIndex != nil)
        {
            let index = maybeIndex.unsafelyUnwrapped
            newQueue.remove(at:index)
        }
        
        return TimerQueueRootState(queue:newQueue)
    }
    
    func pause(fromKey:String) -> TimerQueueRootState{
        var newQueue = queue
        let count = newQueue.count
        for i in 0..<count{
            if(newQueue[i].key == fromKey){
                let newQueueItem = newQueue[i].changePaused(isPaused: !newQueue[i].isPaused)
                newQueue[i] = newQueueItem
                break;
            }
        }
        
        return TimerQueueRootState(queue: newQueue)
    }
    
    func timeup(fromKey:String) -> TimerQueueRootState{
        var newQueue = queue
        let count = newQueue.count
        for i in 0..<count{
            if(newQueue[i].key == fromKey){
                let newQueueItem = newQueue[i].changeTimeup(isTimeup:true)
                newQueue[i] = newQueueItem
                break;
            }
        }
        
        return TimerQueueRootState(queue:newQueue)
    }
    
    func changeRemainSec(fromKey:String, remainSec:Int) -> TimerQueueRootState{
        var newQueue = queue
        for i in newQueue.indices{
            if(newQueue[i].key == fromKey){
                let newQueueItem = newQueue[i].changeRemainSec(remainSec:remainSec)
                newQueue[i] = newQueueItem
                break;
            }
        }
        
        return TimerQueueRootState(queue:newQueue)
    }
}
