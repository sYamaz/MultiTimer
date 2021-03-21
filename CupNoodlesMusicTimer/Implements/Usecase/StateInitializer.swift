//
//  ApplicationActivator.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

class StateInitializer : StateInitializerDelegate{
    @Injected var store:UserSettingStoreDelegate
    @Injected var queue:TimerStoreDelegate
    @Injected var repo:UserSettingDBDelegate
    
    init() {
    }
    
    func Initialize(){
        let state = self.repo.LoadUserSetting()
        store.Import(root:state)
        
        let queueState = self.repo.LoadQueue()
        queue.load(state: queueState)
    }
    
    func Finalize(){
        let state = store.Extract()
        repo.SaveUserSetting(state:state)
        
        let queueState = self.queue.extract()
        repo.SaveQueue(state: queueState)
    }
}


