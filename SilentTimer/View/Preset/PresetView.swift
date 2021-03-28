//
//  PresetView.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/27.
//

import SwiftUI

struct PresetView: View {
    
    @State var isAddMode = false
    @State var isEditMode = false
    /// TimerSettingViewに引き渡すClosure
    @State var sheetClosure:(PresetState) -> Void = {st in print(st)}
    /// TimerSettingViewに引き渡す初期表示値
    @State var minutes:Int = 3
    /// TimerSettingViewに引き渡す初期表示値
    @State var seconds:Int = 0
    
    @Binding var presets:PresetRootState
    @Binding var records:TimerRecordRootState
    @Binding var ongoingCount:Int
    
    let formatter:DateComponentsFormatter = getTimeFormatter()
    let screenSize = UIScreen.main.bounds.size

    
    
    var body: some View {
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            
            // header
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Button(action: {isEditMode.toggle()}, label: {
                    if(!isEditMode){
                        Text("Edit")
                    }
                    else{
                        Text("Finish")
                    }
                })
                .padding()
                Spacer()
                Text("Presets")
                Spacer()
                Button(action: {
                    self.seconds = 0
                    self.minutes = 3
                    self.sheetClosure = {st in self.presets = self.presets.AddPreset(newItem: st)}
                    isAddMode.toggle()
                    
                }, label: {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isAddMode, onDismiss: {
                    print("dismiss")
                }){
                    TimerSettingView(minutes:minutes, seconds: seconds, isEditMode: $isAddMode, closure: $sheetClosure)
                }
                .padding()
            })
            
            // divider
            Divider()
            
            // list
            List{
                ForEach(presets.settings, id: \.key){item in
                    let txt = formatter.string(from: TimeInterval(item.seconds))!
                    if(!isEditMode){
                        Button(
                            action: {
                                
                                let record = item.ToRecord(id: UUID(), now: Date())
                                records = records.append(record)
                                let request = record.toNotificationRequest(title: "ローカル通知テスト", subtitle: "タイマー通知", body: "タイマーによるローカル通知です")
                                request.send()
                                
                                self.ongoingCount = records.records.filter({r in !r.timeup}).count
                            },
                            label: {
                                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                    Text(txt)
                                        .font(.largeTitle)
                                    Text("Timer")
                                        .font(.subheadline)
                                })
                            })
                    }
                    else{
                        Button(action: {
                            self.minutes = item.seconds / 60
                            self.seconds = item.seconds % 60
                            self.sheetClosure = {st in
                                self.presets = self.presets.ReplacePreset(predecate: {s in s.key == item.key}, selector: {old in
                                    PresetState(key: item.key, seconds: st.seconds)
                                })
                            }
                            isAddMode.toggle()
                        }, label: {
                            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                Image(systemName: "square.and.pencil")
                                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                    Text(txt)
                                        .font(.largeTitle)
                                    Text("Timer")
                                        .font(.subheadline)
                                })
                            })
                            
                        })
                    }
                }
                .onDelete(perform: { indexSet in
                    let first = indexSet.first!
                    let key = self.presets.settings[first].key
                    presets = presets.DeletePreset(predecate: {(preset) in return preset.key == key})
                })
            }
        })
    }
}

struct PresetView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        let presets = PresetRootState(settings: [
            PresetState(key: UUID().uuidString, seconds: 180)
        ])
        
        Group {
            PresetView(presets: .constant(presets), records: .constant(TimerRecordRootState(records: [TimerRecordState]())), ongoingCount: .constant(0))
        }
    }
}

