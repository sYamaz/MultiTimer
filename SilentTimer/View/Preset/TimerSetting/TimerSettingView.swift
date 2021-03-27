//
//  TimerSettingView.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/18.
//

import SwiftUI

struct TimerSettingView: View {
    @Injected var usecase:MainTimerSettingDelegate
    
    @State var minutes = 3
    @State var seconds = 0
    
    @Binding var isEditMode:Bool
    
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
                    Text("Cancel")
                }
                .padding()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(50)
                .clipped()
                .shadow(color: Color("shadow.6"), radius: 6, x: 0, y: 0)
                
                Spacer()
                
                Button(action:
                        {
                            let totalSeconds = self.minutes * 60 + self.seconds
                            
                            usecase.createSetting(timerKey: UUID().uuidString, waitForSeconds: totalSeconds)
                            
                            isEditMode.toggle()
                        }){
                    Text("Add")
                }
                .padding()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(50)
                .clipped()
                .shadow(color: Color("shadow.6"), radius: 6, x: 0, y: 0)
                
            }.padding()
        })
    }
}

struct TimerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        TimerSettingView(isEditMode: Binding<Bool>(get: {true}, set: {b in }))
            .onAppear{
                ConfigurePreview()
            }
    }
}
