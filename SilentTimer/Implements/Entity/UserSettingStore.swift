//
//  UserSettingStore.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation


class UserSettingStore : UserSettingStoreDelegate {
    var root:UserSettingRootState
    
    var observers:[UserSettingStoreObserver]
    
    init() {
        
        var defaults = [UserSettingState]()
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"){
            defaults.append(UserSettingState(key: "preview_min3", seconds: 180))
            defaults.append(UserSettingState(key: "preview_min4", seconds: 240))
            defaults.append(UserSettingState(key: "preview_min5", seconds: 300))
        }
        
        root = UserSettingRootState(settings:defaults)
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
    
    func enumerateValues() -> [UserSettingState] {
        print("enumerateValues")
        return self.root.settings
    }
    
    func add(key: String, waitForSeconds: Int) {
        print("add")
        let newRoot = root.append(key: key, waitForSeconds: waitForSeconds)
        updateState(newRoot: newRoot)
    }
    
    func remove(key: String) {
        print("remove")
        updateState(newRoot: root.remove(keyFrom: key))
    }
    
    func edit(key:String, waitForSeconds:Int){
        print("edit")
        updateState(newRoot: root.changeWaitForSeconds(keyFrom: key, waitForSeconds: waitForSeconds))
    }
    
    func Import(root:UserSettingRootState){
        print("import")
        updateState(newRoot: root)
    }
    
    func Extract() -> UserSettingRootState{
        print("extract")
        return root
    }
    
    private func updateState(newRoot:UserSettingRootState){
        if(self.root != newRoot){
            self.root = newRoot
            for i in 0..<observers.count{
                observers[i].StateChanged(root:self.root)
            }
        }
    }
}



