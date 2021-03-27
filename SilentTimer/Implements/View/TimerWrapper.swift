//
//  TimerWrapper.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/19.
//

import Foundation
class TimerWrapper : TimerDelegate
{
    private var timer:Timer? = nil
    
    func isValid() -> Bool{
        return timer != nil
    }
    
    func schedule(intervalSeconds:Double, repeats:Bool, block:@escaping (Timer) -> Void){
        
        self.timer = Timer(timeInterval: intervalSeconds, repeats: repeats, block: block)
        RunLoop.main.add(self.timer!, forMode: .common)
       
        let now = Date()
        print("now:\(now)")
        let due = now.addingTimeInterval(180)
        print("due:\(due)")
        let debugTimer = Timer.init(timeInterval: 180, repeats: false, block: {t in
            print("timeup:\(Date())")
        })
        RunLoop.main.add((debugTimer), forMode: .common)
    }
    
    func invalidate(){
        timer?.invalidate()
        timer = nil
    }
}
