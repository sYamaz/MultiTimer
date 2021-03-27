//
//  UserSettingDBProtocol.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

protocol UserSettingDBDelegate {
    func LoadQueue() -> TimerQueueRootState
    func SaveQueue(state:TimerQueueRootState)
    func LoadUserSetting() -> UserSettingRootState
    func SaveUserSetting(state:UserSettingRootState)
}
