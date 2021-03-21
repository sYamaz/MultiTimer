//
//  PauseState.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation

class PauseState
{
    let remainSec:Int
    let identifier:String
    
    init(identifier:String, remainSec:Int){
        self.remainSec = remainSec
        self.identifier = identifier
    }
}
