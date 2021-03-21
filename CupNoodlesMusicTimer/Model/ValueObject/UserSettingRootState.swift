//
//  UserSettingRootState.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation
extension UserSettingRootState : Codable{}
struct UserSettingRootState : Equatable{
    let settings:[UserSettingState]
    
    func append(key:String, waitForSeconds:Int) -> UserSettingRootState{
        var newSettings = settings
        
        newSettings.append(UserSettingState(key: key, seconds: waitForSeconds))
        
        return UserSettingRootState(settings: newSettings)
    }
    
    func remove(keyFrom:String) -> UserSettingRootState{
        var newSettings = settings
        
        let maybeIndex = newSettings.lastIndex{$0.key == keyFrom}
        if(maybeIndex != nil){
            let index = maybeIndex.unsafelyUnwrapped
            newSettings.remove(at: index)
        }
        
        return UserSettingRootState(settings: newSettings)
    }
    
    func changeWaitForSeconds(keyFrom:String, waitForSeconds:Int) -> UserSettingRootState{
        var newSettings = settings
        
        for i in 0..<newSettings.count
        {
            if(newSettings[i].key == keyFrom){
                newSettings[i] = newSettings[i].changeWaitForSeconds(waitForSeconds: waitForSeconds)
            }
        }
        
        return UserSettingRootState(settings: newSettings)
    }
}




