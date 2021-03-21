//
//  ContentView.swift
//  CupNoodlesMusicTimer
//
//  Created by sYamaz on 2021/02/16.
//

import SwiftUI
import AudioToolbox
import Combine

// "viewの"状態を保持する
class ContentViewModel : ObservableObject, UserSettingStoreObserver, TimerStoreObserver{
    func StateChanged(root: TimerQueueRootState) {
        DispatchQueue.main.async {
            self.queue = root
        }
    }
    
    func StateChanged(root: UserSettingRootState) {
        self.root = root
    }
    
    @Published var sw:Bool = true
    
    @Published var root:UserSettingRootState = UserSettingRootState(settings: [UserSettingState]())
    
    @Published var queue:TimerQueueRootState = TimerQueueRootState()
    
}

struct ContentView: View {
    
    @Injected var usecase:MainTimerSettingDelegate
    @Injected var command:RequestTimerDelegate
    @Injected var queue:TimerStoreDelegate
    @Injected var store:UserSettingStoreDelegate
    @Injected var timer:TimerDelegate
    @Injected var alarm:AlarmDelegate
    
    @State var isEditMode = false
    @State var tabSelection:PageKind = .Setting
    @ObservedObject var vm:ContentViewModel = ContentViewModel()
    
    let calender:Calendar
    let formatter:DateComponentsFormatter
    
    enum PageKind{
        case Setting
        case Queue
    }
    
    init() {
        calender = Calendar.current
        formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropLeading]
        
        self.vm.root = store.Extract();
        self.vm.queue = queue.extract()
        self.store.Observe(observer: vm)
        self.queue.observe(observer: vm)
    }
    
    private func TimerElapsed(t:Timer){
        let _ = self.command.declement(count: 1)
    }
    
    var body: some View {
        
        let screenSize = UIScreen.main.bounds.size
        TabView(selection:$tabSelection){
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    VStack(alignment: .center, spacing: 16, content: {
                        if(self.vm.root.settings.isEmpty)
                        {
                            Text("タイマー設定がありません")
                            
                        }
                        else
                        {
                            ForEach(self.vm.root.settings, id: \.key){item in
                                
                                let txt = ConvertToTimeString(seconds: item.seconds)
                                
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: nil, content: {
                                    Button(action:{
                                        command.startTimer(waitForSeconds: item.seconds)
                                    }){
                                        Text(txt)
                                    }
                                    .frame(width: screenSize.width * 0.70, height:50)
                                    .background(Color(UIColor.systemGray6))
                                })
                                .cornerRadius(5)
                                .clipped()
                                .shadow(color: Color("shadow.6"), radius: 5, x: 0, y: 0)
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(
                                        action: {
                                            usecase.removeSetting(timerKey: item.key)
                                        },
                                        label: {
                                            Label("Delete", systemImage:"trash")
                                        })
                                }))
                            }
                        }
                    })
                    .frame(minHeight:screenSize.height * 0.7)
                    .frame(minWidth:screenSize.width)
                })
                .frame(height:screenSize.height * 0.7)
                .frame(minWidth:screenSize.width)
                // add timer
                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    if(vm.root.settings.isEmpty)
                    {
                        Button(action:{
                            isEditMode.toggle()
                        })
                        {
                            Image(systemName: "plus")
                            Text("タイマー設定を追加する")
                        }
                        .sheet(isPresented: $isEditMode, content: {
                            TimerSettingView(isEditMode: $isEditMode)
                        })
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(30)
                        .clipped()
                        .shadow(color:Color("shadow.6"), radius: 5, x:0, y:0)
                    }
                    else
                    {
                        Button(action:{
                            isEditMode.toggle()
                        })
                        {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $isEditMode, content: {
                            TimerSettingView(isEditMode: $isEditMode)
                        })
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(30)
                        .clipped()
                        .shadow(color:Color("shadow.6"), radius: 5, x:0, y:0)
                    }
                }).padding()
            })
            .tabItem {
                Image(systemName: "timer")
                Text("タイマー設定")
            }.tag(PageKind.Setting)
            
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                if(self.vm.queue.queue.isEmpty)
                {
                    Text("測定中のタイマーはありません").padding()
                    Button(action:{self.tabSelection = .Setting}){
                        Text("設定画面へ移動する")
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
                                    if(queueItem.timeup)
                                    {
                                        Image(systemName: "alarm")
                                    }
                                    else if(queueItem.isPaused == false)
                                    {
                                        Image(systemName: "pause")
                                    }
                                    else
                                    {
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
                print("appear")
                timer.schedule(intervalSeconds: 1.0, repeats: true, block: self.TimerElapsed)
            })
            .onDisappear(perform: {
                print("disappear")
                timer.invalidate()
            })
            .tabItem {
                Image(systemName: "list.dash")
                Text("測定中")
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

func ConvertToTimeString(seconds:Int) -> String{
    let minutes = seconds / 60
    let seconds = seconds % 60
    
    let txt = "\(minutes) m \(String(format: "%02d", seconds)) s"
    
    return txt
}

