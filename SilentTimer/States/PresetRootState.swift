//
//  UserSettingRootState.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation
extension PresetRootState : Codable{}
struct PresetRootState : Equatable{
    let settings:[PresetState]
}




