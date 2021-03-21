//
//  SoundSettingView.swift
//  CupNoodlesMusicTimer
//
//  Created by 山﨑駿 on 2021/03/14.
//

import SwiftUI

struct SoundSettingView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Section{
                List{
                 Text("BBB")
                }
            }
            Section{
                List{
                    Text("aaa")
                }
            }
        })

    }
}

struct SoundSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingView()
    }
}
