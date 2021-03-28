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
    @Binding var records:TimerRecordRootState

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            if(self.records.records.isEmpty)
            {
                Text("No timers to wait for.").padding()
                Button(action:{self.tabState = .Setting}){
                    Text("Back to presets view")
                }.padding()
            }
            else
            {
                List{
                    ForEach(records.records, id: \.key) { queueItem in
                        
                        let txt = formatter.string(from: TimeInterval(queueItem.remainSec))!
                        
                        HStack{
                            Text(txt)
                                .font(.largeTitle)
                            Spacer(minLength: 1)
                            
                            if(queueItem.timeup){
                                Image(systemName: "alarm")
                            }
                            else if(queueItem.isPaused == false){
                                Button(action: {
                                    // ポーズ対象のレコードを通知センターから削除
                                    let _ = queueItem.key.deleteFromPendingStore()
                                    // ポーズ状態のトグル
                                    self.records = records.togglePause(predicate: {rec in rec.key == queueItem.key})
                                }, label: {
                                    Image(systemName: "pause")
                                })
                            }
                            else{
                                Button(action: {
                                    //新規に通知リクエストする
                                    let request = queueItem.toNotificationRequest(title: "再開したタイマー", subtitle: "AAA", body: "BBB")
                                    request.send()
                                    records = records
                                        .togglePause(predicate: {rec in rec.key == queueItem.key})
                                        .edit(predicate: {rec in rec.key == queueItem.key})
                                            {old in TimerRecordState(key: old.key, dueDate: Date(timeInterval: Double(old.remainSec), since: Date()), isPaused: old.isPaused, timeup: old.timeup, remainSec: old.remainSec)}
                                }, label: {
                                    Image(systemName: "play")
                                })
                            }
                            
                            
                        }
                        .padding()
                        .clipped()
                    }
                    .onDelete(perform: { indexSet in
                        
                        let record = records.records[indexSet.first!]
                        self.records = records.delete(predicate: {r in return r.key == record.key})
                        
                        // 通知ストアから削除
                        let _ = record.key.deleteFromPendingStore()
                    })
                }
            }
        })
        .onReceive(ti, perform: { _ in
            let now = Date()
            /// 実行中タイマーのステータスを変更する
            NotificationIdentifier.sinkPendingIdentifiers{pendingIds in
                records = records.edit(predicate: {rec in pendingIds.contains(rec.key) && (!rec.isPaused) && (!rec.timeup)}, selector: {
                    old in
                    let newReaminSec = Int(now.distance(to: old.dueDate))
                    return old.changeRemainSec(newReaminSec)
                })
                
                ///終了したタイマーのステータスを変更する
                NotificationIdentifier.sinkDeliveredIdentifiers{
                    deliveredIds in
                    records = records.edit(predicate: {rec in deliveredIds.contains(rec.key)}, selector: {old in old.setTimeup()})
                }
                
                self.ongoingCount = records.records.filter({rec in !rec.timeup}).count
            }
        })
    }
}

struct OngoingView_Previews: PreviewProvider {
    static var previews: some View {
        OngoingView( tabState: .constant(.Queue), ongoingCount: .constant(0), records: .constant(TimerRecordRootState(records: [TimerRecordState]())))

    }
}
