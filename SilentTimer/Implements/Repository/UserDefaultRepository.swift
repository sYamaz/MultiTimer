//
//  UserDefaultRepository.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

class UserDefaultRepository: UserSettingDBDelegate {
    func LoadQueue() -> TimerRecordRootState {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = UserDefaults.standard.data(forKey: "queue.v1"),
            let state = try? decoder.decode(TimerRecordRootState.self, from: data) else{
                return TimerRecordRootState()
            }
     
        
        print("<queue>--------")
        print(state)
        print("---------------")
        
        return state
    }
    
    func SaveQueue(state: TimerRecordRootState) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(state) else{
            return
        }
        
        UserDefaults.standard.set(data, forKey: "queue.v1")
    }

    
    func LoadUserSetting() -> PresetRootState {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = UserDefaults.standard.data(forKey: "setting.v1"),
            let state = try? decoder.decode(PresetRootState.self, from: data) else{
            
            var defaults = [PresetState]()
            let min3 = PresetState.init(key:"3min", seconds: 180)
            let min4 = PresetState.init(key: "4min", seconds: 240)
            let min5 = PresetState.init(key: "5min", seconds: 300)
            
            defaults.append(min3)
            defaults.append(min4)
            defaults.append(min5)
            
            
            return PresetRootState(settings: defaults)
               
            }
        
        print("<setting>--------")
        print(state)
        print("-----------------")
        return state
    
    }
    
    func SaveUserSetting(state: PresetRootState) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(state) else{
            return
        }
        
        UserDefaults.standard.set(data, forKey: "setting.v1")
    }
}
