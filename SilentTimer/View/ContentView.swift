//
//  ContentView.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import SwiftUI
import Combine



struct ContentView: View {
    @State var tabSelection:PageKind = .Setting
    @State var ongoingCount:Int = 0
    
    @AppStorage("setting.v1") var presets_data:Data?
    @AppStorage("queue.v1") var queue_data:Data?
    
    @State var presets:PresetRootState = PresetRootState(settings: [PresetState]())
    @State var records:TimerRecordRootState = TimerRecordRootState(records: [TimerRecordState]())
    
    let presets_default = PresetRootState(settings: [
        PresetState(key: UUID().uuidString, seconds: 180),
        PresetState(key: UUID().uuidString, seconds: 240),
        PresetState(key: UUID().uuidString, seconds: 300)
    ])
    
    let records_default = TimerRecordRootState(records: [TimerRecordState]())
    
    var body: some View {
        TabView(selection:$tabSelection){
            
            PresetView(presets: $presets, records: $records, ongoingCount: $ongoingCount)
            .tabItem {
                Image(systemName: "timer")
                Text("Presets")
            }.tag(PageKind.Setting)
            
            
            OngoingView(tabState: $tabSelection, ongoingCount: $ongoingCount, records: $records)
            .tabItem {
                Image(systemName: "list.dash")
                Text("On going(\(ongoingCount))")
            }
            .tag(PageKind.Queue)
            
        }
        .onAppear{
            print("onAppear")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                self.records = try decoder.decode(TimerRecordRootState.self, from: queue_data.unsafelyUnwrapped)
            }
            catch let error{
                print(error)
                self.records = self.records_default
            }
            
            do{
                self.presets = try decoder.decode(PresetRootState.self, from: presets_data.unsafelyUnwrapped)
                if(self.presets.settings.isEmpty){
                    self.presets = self.presets_default
                }
            }
            catch let error{
                print(error)
                self.presets = self.presets_default
            }
        }
        .onDisappear{
            print("onDisappear")
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            
            do{
                let d = try encoder.encode(presets)
                self.presets_data = d
            }
            catch let error{
                print(error)
            }
            
            do{
                let d = try encoder.encode(records)
                self.queue_data = d
            }
            catch let error{
                print(error)
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider { 
    static var previews: some View {
        ContentView()
    }
}


