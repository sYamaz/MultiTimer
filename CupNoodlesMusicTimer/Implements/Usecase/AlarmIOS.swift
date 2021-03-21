//
//  AlarmRepository.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/19.
//

import Foundation
import AudioToolbox
import AVFoundation
import UserNotifications
class AlarmIOS : AlarmDelegate{
    init(){
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSession.Category.playback)
    }
    
    func AlarmSound()
    {
        
        AudioServicesPlayAlertSoundWithCompletion(1313, nil)
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
    }
}
