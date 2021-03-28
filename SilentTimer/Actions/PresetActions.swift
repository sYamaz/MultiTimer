//
//  EditPreset.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/28.
//

import Foundation

extension PresetRootState{
    func ReplacePreset(predecate: (_ :PresetState) -> Bool, selector: (_ :PresetState) -> PresetState) -> PresetRootState{
        var newSettings = self.settings
        for i in newSettings.indices{
            let old = newSettings[i]
            if(predecate(old)){
                let new = selector(old)
                newSettings[i] = new
            }
        }
        return PresetRootState(settings: newSettings)
    }
}

extension PresetRootState{
    func AddPreset(newItem:PresetState) -> PresetRootState{
        var newSettings = self.settings
        newSettings.append(newItem)
        return PresetRootState(settings:newSettings)
    }
}

extension PresetRootState{
    func DeletePreset(predecate: (_: PresetState) -> Bool) -> PresetRootState{
        var newSettings = self.settings
        for i in newSettings.indices.reversed(){
            let item = newSettings[i]
            if(predecate(item)){
                newSettings.remove(at: i)
            }
        }
        return PresetRootState(settings: newSettings)
    }
}

extension PresetState{
    func ToRecord(id:UUID, now:Date) -> TimerRecordState{
        let remain = self.seconds
        let dueDate = Date(timeInterval:Double(remain), since: now)
        return TimerRecordState(key: id.uuidString, dueDate: dueDate, isPaused: false, timeup: false, remainSec: remain)
    }
}
