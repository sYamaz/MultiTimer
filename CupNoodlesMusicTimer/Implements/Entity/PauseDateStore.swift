//
//  PauseDateStore.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation
class PauseDateStore : PauseStoreDelegate
{
    var state:PauseStateRoot = PauseStateRoot(items: [PauseState]())
    func pop(identifier: String) -> PauseState {
        let ret = state.pop(identifier: identifier)
        
        return ret
    }
    
    func update(identifier: String, remainSec: Int) {
        state.update(identifier: identifier, remainSec: remainSec)
    }
}
