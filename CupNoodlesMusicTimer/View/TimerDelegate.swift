//
//  TimerDelegate.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/19.
//

import Foundation
protocol TimerDelegate{
    func isValid() -> Bool
    func invalidate()
    func schedule(intervalSeconds:Double, repeats:Bool, block:@escaping (Timer) -> Void)
}
