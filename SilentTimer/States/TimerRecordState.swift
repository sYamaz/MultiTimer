//
//  TimerRecordState.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation
// Keep Immutable
extension TimerRecordState : Codable{}
struct TimerRecordState : Equatable{
    let key:NotificationIdentifier
    let dueDate:Date
    let isPaused:Bool
    let timeup:Bool
    let remainSec:Int
}
