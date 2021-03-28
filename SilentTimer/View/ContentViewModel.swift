//
//  ContentViewModel.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/27.
//

import Foundation
// "viewの"状態を保持する
class ContentViewModel : ObservableObject, UserSettingStoreObserver, TimerStoreObserver{
    
    init(){

    }
    
    func StateChanged(root: TimerRecordRootState) {
        DispatchQueue.main.async {
            self.queue = root
        }
    }
    
    func StateChanged(root: PresetRootState) {
        self.root = root
    }
    
    @Published var root:PresetRootState = PresetRootState(settings: [PresetState]())
    
    @Published var queue:TimerRecordRootState = TimerRecordRootState()
    
}
