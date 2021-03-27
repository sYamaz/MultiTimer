//
//  PreviewUserSettingStore.swift
//  CupNoodlesMusicTimer
//
//  Created by 山﨑駿 on 2021/02/17.
//

import Foundation
class PreviewUserSettingStore : UserSettingStoreDelegate{

    

    
    var root:UserSettingRootState
    var observers:[UserSettingStoreObserver]
    init() {
        
        var defaults = [UserSettingState]()
        let min3 = UserSettingState(key: "min3", seconds: 180)
        let min4 = UserSettingState(key: "min4", seconds: 240)
        let min5 = UserSettingState(key: "min5", seconds: 300)
        defaults.append(min3)
        defaults.append(min4)
        defaults.append(min5)
        root = UserSettingRootState(settings: defaults)
        observers = [UserSettingStoreObserver]()
    }
    func Observe(observer: UserSettingStoreObserver) {
        self.observers.append(observer)
    }
    
    func GetKeysOfUserSettings() -> [String]
    {
        return Array(self.root.settings.map{$0.key})
    }
    
    func GetWaitForSeconds(keyFrom: String) -> Int{
        for i in 0..<root.settings.count{
            if(root.settings[i].key == keyFrom)
            {
                return root.settings[i].seconds
            }
        }
        
        return -1
    }
    
    func add(key: String, waitForSeconds: Int) {
        <#code#>
    }
    
    func Import(root state:UserSettingRootState){
        root = state
    }
    
    func Extract() -> UserSettingRootState{
        return root
    }
}
