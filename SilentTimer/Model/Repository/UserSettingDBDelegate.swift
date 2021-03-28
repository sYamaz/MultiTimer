//
//  UserSettingDBProtocol.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

protocol UserSettingDBDelegate {
    func LoadQueue() -> TimerRecordRootState
    func SaveQueue(state:TimerRecordRootState)
    func LoadUserSetting() -> PresetRootState
    func SaveUserSetting(state:PresetRootState)
}
