//
//  PresetView.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/27.
//

import SwiftUI

struct PresetView: View {
    
    @Injected var usecase:MainTimerSettingDelegate
    @Injected var command:RequestTimerDelegate
    @Injected var store:UserSettingStoreDelegate
    
    @State var isEditMode = false
    @ObservedObject var vm:ContentViewModel = ContentViewModel()
    
    let formatter:DateComponentsFormatter
    
    init() {
        formatter = getTimeFormatter()
        
        self.vm.root = store.Extract();
        self.store.Observe(observer: vm)
        
    }
    
    let screenSize = UIScreen.main.bounds.size
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            
            // header
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Button(action: {}, label: {
                    Text("Edit")
                })
                .padding()
                Spacer()
                Text("Presets")
                Spacer()
                Button(action: {isEditMode.toggle()}, label: {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isEditMode, content: {
                    TimerSettingView(isEditMode: $isEditMode)
                })
                .padding()
                
            })
            
            // divider
            Divider()
            
            // list
            List{
                ForEach(self.vm.root.settings, id: \.key){item in
                    Button(action: {command.startTimer(waitForSeconds: item.seconds)}, label: {
                        let txt = formatter.string(from: TimeInterval(item.seconds))!
                        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Text(txt)
                                .font(.largeTitle)
                            Text("Timer")
                                .font(.subheadline)
                        })
                        
                    })
                }
                .onDelete(perform: { indexSet in
                    let first = indexSet.first!
                    let key = self.vm.root.settings[first].key
                    usecase.removeSetting(timerKey: key)
                })
            }
        })
    }
}

struct PresetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PresetView()
                .onAppear
                {
                    ConfigurePreview()
                }
            PresetView()
                .onAppear
                {
                    ConfigurePreview()
                }
        }
    }
}
