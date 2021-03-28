//
//  TimerSettingView.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/18.
//

import SwiftUI

struct TimerSettingView: View {
    
    @State var minutes:Int
    @State var seconds:Int
    
    @Binding var isEditMode:Bool
    @Binding var closure:(PresetState) -> Void
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            
            
            
            HStack{
                Picker(selection: $minutes, label: Text("min"), content: {
                    ForEach(0..<60){index in
                        Text("\(index)").tag(index)
                    }
                })
                .frame(width: 40)
                .clipped()
                
                Text("min")
                
                Picker(selection: $seconds, label: Text("sec"), content:{
                    ForEach(0..<60){index in
                        Text("\(index)").tag(index)
                    }
                })
                .frame(width: 40)
                .clipped()
                
                Text("sec")
            }
            .padding()
            HStack{
                Button(action:{isEditMode.toggle()}){
                    ZStack(alignment: /*@START_MENU_TOKEN@*/Alignment(horizontal: .center, vertical: .center)/*@END_MENU_TOKEN@*/, content: {
                        Text("Cancel")
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                            .background(Color(UIColor.systemFill))
                            .clipShape(Circle())
                        Circle()
                            .stroke(Color(UIColor.systemBackground), lineWidth: 2)
                            .frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                    })
                }
                
                Spacer()
                
                Button(action:
                        {
                            let totalSeconds = self.minutes * 60 + self.seconds
                            let item = PresetState(key: UUID().uuidString, seconds: totalSeconds)
                            closure(item)
                            isEditMode.toggle()
                        }){
                    ZStack(alignment: /*@START_MENU_TOKEN@*/Alignment(horizontal: .center, vertical: .center)/*@END_MENU_TOKEN@*/, content: {
                        Text("OK")
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                            .background(Color.accentColor.opacity(0.2))
                            .clipShape(Circle())
                        Circle()
                            .stroke(Color(UIColor.systemBackground), lineWidth: 2)
                            .frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                }
                .disabled((self.minutes * 60 + self.seconds) == 0)
        
            }.padding(36)
        })
    }
}

struct TimerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        TimerSettingView(minutes:1, seconds:35, isEditMode: .constant(true), closure: .constant({st in print(st)}))
    }
}
