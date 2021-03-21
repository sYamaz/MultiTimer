//
//  UserSetting.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

extension UserSettingState : Codable{}
struct UserSettingState : Equatable{
    let key:String
    let seconds:Int
    
    func changeWaitForSeconds(waitForSeconds:Int) -> UserSettingState{
        return UserSettingState(key: key, seconds: waitForSeconds)
    }
        
}
