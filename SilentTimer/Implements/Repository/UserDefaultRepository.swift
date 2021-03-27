//
//  UserDefaultRepository.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

class UserDefaultRepository: UserSettingDBDelegate {
    func LoadQueue() -> TimerQueueRootState {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = UserDefaults.standard.data(forKey: "queue.v1"),
            let state = try? decoder.decode(TimerQueueRootState.self, from: data) else{
                return TimerQueueRootState()
            }
     
        
        print("<queue>--------")
        print(state)
        print("---------------")
        
        return state
    }
    
    func SaveQueue(state: TimerQueueRootState) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(state) else{
            return
        }
        
        UserDefaults.standard.set(data, forKey: "queue.v1")
    }

    
    func LoadUserSetting() -> UserSettingRootState {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = UserDefaults.standard.data(forKey: "setting.v1"),
            let state = try? decoder.decode(UserSettingRootState.self, from: data) else{
            
            var defaults = [UserSettingState]()
            let min3 = UserSettingState.init(key:"3min", seconds: 180)
            let min4 = UserSettingState.init(key: "4min", seconds: 240)
            let min5 = UserSettingState.init(key: "5min", seconds: 300)
            
            defaults.append(min3)
            defaults.append(min4)
            defaults.append(min5)
            
            
            return UserSettingRootState(settings: defaults)
               
            }
        
        print("<setting>--------")
        print(state)
        print("-----------------")
        return state
    
    }
    
    func SaveUserSetting(state: UserSettingRootState) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(state) else{
            return
        }
        
        UserDefaults.standard.set(data, forKey: "setting.v1")
    }
}
