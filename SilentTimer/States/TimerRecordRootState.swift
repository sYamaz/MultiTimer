//
//  TimerRecordRootState.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/17.
//

import Foundation

extension TimerRecordRootState : Codable{}
struct TimerRecordRootState : Equatable{
    let records:[TimerRecordState]
}
