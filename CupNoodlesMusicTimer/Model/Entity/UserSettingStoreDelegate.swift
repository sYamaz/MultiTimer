//
//  UserSettingStoreProtocol.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation
protocol UserSettingStoreDelegate {
    func Observe(observer: UserSettingStoreObserver)
    // for initialize
    func Import(root:UserSettingRootState)
    // for finalyze
    func Extract() -> UserSettingRootState
    // get
    func GetKeysOfUserSettings() -> [String]
    // get
    func GetWaitForSeconds(keyFrom: String) -> Int
    func enumerateValues() -> [UserSettingState]
    
    // command
    func add(key:String, waitForSeconds:Int)
    // command
    func remove(key:String)
    // command
    func edit(key:String, waitForSeconds:Int)
}

protocol UserSettingStoreObserver{
    func StateChanged(root:UserSettingRootState)
}
