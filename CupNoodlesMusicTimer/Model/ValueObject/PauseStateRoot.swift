//
//  PauseSateRoot.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation

class PauseStateRoot
{
    private var table:Dictionary<String, PauseState>
    
    init(items:[PauseState]){
        table = Dictionary<String, PauseState>()
        for item in items{
            self.table.updateValue(item, forKey: item.identifier)
        }
    }
    
    func containsKey(identifier:String) -> Bool{
        return table.keys.contains(identifier)
    }
    
    func getValue(identifier:String) -> PauseState{
        guard let ret = table[identifier] else {
            return PauseState(identifier: identifier, remainSec: -1)
        }
        
        return ret;
    }
    
    func update(identifier:String, remainSec:Int){
        table.updateValue(PauseState(identifier: identifier, remainSec: remainSec), forKey: identifier)
    }
    
    func pop(identifier:String) -> PauseState{
        let ret = getValue(identifier: identifier)
        if(containsKey(identifier: identifier))
        {
            table.removeValue(forKey: identifier)
        }
        return ret
    }
}
