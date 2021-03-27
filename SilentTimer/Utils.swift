//
//  Utils.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/27.
//

import Foundation

func getTimeFormatter() -> DateComponentsFormatter{
    _ = Calendar.current
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = [.dropLeading]
    return formatter
}
