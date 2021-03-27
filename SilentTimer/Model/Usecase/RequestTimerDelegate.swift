//
//  RequestTimerDelegate.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation
protocol RequestTimerDelegate{

    /// start new timer instance
    /// - Parameter timerKey: unique key of timer setting
    func startTimer(waitForSeconds:Int)
    
    
    /// <#Description#>
    /// - Parameter keyFromQueue: unique key of timer instance
    func togglePause(keyFromQueue:String)
    
    /// <#Description#>
    /// - Parameter keyFromQueue: unique key of timer instance
    func removeTimer(keyFromQueue:String)
    func declement(count:Int) -> Bool
}
