//
//  TimerSettingService.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation
class TimerSettingService : MainTimerSettingDelegate
{
    @Injected var store:UserSettingStoreDelegate
    
    func createSetting(timerKey:String, waitForSeconds:Int){
        store.add(key: timerKey, waitForSeconds: waitForSeconds)
    }
    
    func removeSetting(timerKey: String) {
        store.remove(key: timerKey)
    }
    
    func editSetting(timerKey: String, waitForSeconds: Int) {
        store.edit(key:timerKey, waitForSeconds: waitForSeconds)
    }
}
