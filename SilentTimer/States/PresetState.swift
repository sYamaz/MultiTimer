//
//  UserSetting.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

extension PresetState : Codable{}
struct PresetState : Equatable{
    let key:String
    let seconds:Int
}
