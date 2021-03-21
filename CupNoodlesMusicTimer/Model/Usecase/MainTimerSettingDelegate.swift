//
//  MainTimerDelegate.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

protocol MainTimerSettingDelegate {
    /// get keys of timer presets
    func enumerateKeys() -> [String]
    
    /// make timer preset
    /// - Parameters:
    ///   - timerKey: unique key of timer setting
    ///   - waitForSeconds: timer value
    func createSetting(timerKey:String, waitForSeconds:Int)
    
    
    /// delete setting
    /// - Parameter timerKey: unique key of timer setting
    func removeSetting(timerKey:String)
    
    
    /// edit property of timer setting
    /// - Parameters:
    ///   - timerKey: unique key of timer setting
    ///   - waitForSeconds: new timer value
    func editSetting(timerKey:String, waitForSeconds:Int)
}
