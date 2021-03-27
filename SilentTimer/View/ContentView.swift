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
    var body: some View {
        TabView(selection:$tabSelection){
            
            PresetView()
            .tabItem {
                Image(systemName: "timer")
                Text("Presets")
            }.tag(PageKind.Setting)
            
            
            OngoingView(tabState: $tabSelection, ongoingCount: $ongoingCount)
            .tabItem {
                Image(systemName: "list.dash")
                Text("On going(\(ongoingCount))")
            }
            .tag(PageKind.Queue)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    init() {
        ConfigurePreview()
    }
    
    static var previews: some View {
        ContentView()
    }
}


