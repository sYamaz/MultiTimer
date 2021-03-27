//
//  OngoingView.swift
//  SilentTimer
//
//  Created by 山﨑駿 on 2021/03/27.
//

import SwiftUI
import Combine
struct OngoingView: View {
    let formatter:DateComponentsFormatter = getTimeFormatter()
    let observerUuid:UUID = UUID()
    let ti = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    @Binding var tabState:PageKind
    @Binding var ongoingCount:Int
    @ObservedObject var vm:ContentViewModel = ContentViewModel()

    @Injected var command:RequestTimerDelegate
    @Injected var queue:TimerStoreDelegate
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            if(self.vm.queue.queue.isEmpty)
            {
                Text("No timers to wait for.").padding()
                Button(action:{self.tabState = .Setting}){
                    Text("Back to presets view")
                }.padding()
            }
            else
            {
                List{
                    ForEach(self.vm.queue.queue, id: \.key) { queueItem in
                        
                        let txt = formatter.string(from: TimeInterval(queueItem.remainSec))!
                        
                        HStack{
                            Text(txt)
                            Spacer(minLength: 1)
                            Button(action: {command.togglePause(keyFromQueue: queueItem.key)}) {
                                if(queueItem.timeup){
                                    Image(systemName: "alarm")
                                }
                                else if(queueItem.isPaused == false){
                                    Image(systemName: "pause")
                                }
                                else{
                                    Image(systemName: "play")
                                }
                            }
                            
                        }
                        .padding()
                        .clipped()
                    }
                    .onDelete(perform: { indexSet in
                        let key = vm.queue.queue[indexSet.first.unsafelyUnwrapped].key
                        command.removeTimer(keyFromQueue: key)
                    })
                }
            }
        })
        .onAppear(perform: {
            self.queue.observe(id:observerUuid, observer: vm)
            self.vm.queue = queue.extract()
            
            
        })
        .onDisappear(perform: {
        })
        .onReceive(ti, perform: { _ in
            let _ = self.command.declement(count: 1)
        })
    }
}

struct OngoingView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingView( tabState: .constant(.Queue), ongoingCount: .constant(0))
            .onAppear{
                ConfigurePreview()
            }
    }
}
