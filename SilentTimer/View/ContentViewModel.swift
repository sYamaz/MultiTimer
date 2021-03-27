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
    
    func StateChanged(root: TimerQueueRootState) {
        DispatchQueue.main.async {
            self.queue = root
        }
    }
    
    func StateChanged(root: UserSettingRootState) {
        self.root = root
    }
    
    @Published var root:UserSettingRootState = UserSettingRootState(settings: [UserSettingState]())
    
    @Published var queue:TimerQueueRootState = TimerQueueRootState()
    
}
