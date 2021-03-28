//
//  SilentTimerApp.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import SwiftUI
import UserNotifications
import AVFoundation

class AppDelegate : UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate
{
    // アプリケーション起動直後の初期
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        // 通知許可を取得する
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge])
            {
                (granted, _) in
                // ユーザーが通知を許可した場合
                if granted
                {
                    UNUserNotificationCenter.current().delegate = self
                }
            }
        return true;
    }
    
    
    /// foregroundでも通知
    /// - Parameters:
    ///   - center: <#center description#>
    ///   - notification: <#notification description#>
    ///   - completionHandler: <#completionHandler description#>
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        if #available(iOS 14.0, *)
        {
            completionHandler([[.banner, .list, .sound]])
        }
        else
        {
            completionHandler([[.alert, .sound]])
        }
    }
        
    
    /// 通知をタップした時の処理
    /// - Parameters:
    ///   - center: <#center description#>
    ///   - response: <#response description#>
    ///   - completionHandler: <#completionHandler description#>
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        completionHandler()
    }
    
    // アプリケーション終了処理
    func applicationWillTerminate(_ application: UIApplication) {

    }
}

@main
struct SilentTimerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


