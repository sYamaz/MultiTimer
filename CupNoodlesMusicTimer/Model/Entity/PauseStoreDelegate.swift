//
//  PauseStoreDelegate.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/03/14.
//

import Foundation

protocol PauseStoreDelegate{
    func pop(identifier:String) -> PauseState
    func update(identifier:String, remainSec:Int)
}
