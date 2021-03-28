//
//  UserSettingStoreProtocol.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation
protocol UserSettingStoreDelegate {
    func Observe(observer: UserSettingStoreObserver)
    // for initialize
    func Import(root:PresetRootState)
    // for finalyze
    func Extract() -> PresetRootState
    // get
    func GetKeysOfUserSettings() -> [String]
    // get
    func GetWaitForSeconds(keyFrom: String) -> Int
    func enumerateValues() -> [PresetState]
    
    // command
    func add(key:String, waitForSeconds:Int)
    // command
    func remove(key:String)
    // command
    func edit(key:String, waitForSeconds:Int)
}

protocol UserSettingStoreObserver{
    func StateChanged(root:PresetRootState)
}
