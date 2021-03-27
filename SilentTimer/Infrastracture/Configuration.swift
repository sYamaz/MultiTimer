//
//  Configuration.swift
//  SilentTimer
//
//  Created by sYamaz on 2021/02/16.
//

import Foundation

extension Resolver : ResolverRegistering{

    public static func registerAllServices()
    {
        if(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1")
        {
            ConfigurePreview()
        }
        else if(NSClassFromString("XCTest") != nil)
        {
            ConfigureTest()
        }
        else
        {
            ConfigureApp()
        }
    }
}
    
func ConfigureApp()
{
    Resolver.register(TimerDelegate.self){TimerWrapper()}.scope(.application)
    
    // ViewModel
    Resolver.register(ContentViewModel.self){ContentViewModel()}.scope(.graph)
    
    // Usecase
    Resolver.register(MainTimerSettingDelegate.self){ TimerSettingService() }.scope(.graph)
    Resolver.register(RequestTimerDelegate.self){ LocalNotificationIntervalTimer() }.scope(.graph)
    Resolver.register(StateInitializerDelegate.self){StateInitializer()}.scope(.graph)
    
    // repository
    Resolver.register(UserSettingDBDelegate.self){ UserDefaultRepository() }.scope(.application)

        
    // entity
    Resolver.register(UserSettingStoreDelegate.self){UserSettingStore()}.scope(.application)
    Resolver.register(TimerStoreDelegate.self){TimerQueue()}.scope(.application)

}

/// テストのためのResolverセットアップ
func ConfigureTest()
{
    
}

/// preview表示のためのResolverセットアップ
func ConfigurePreview()
{
    Resolver.register(TimerDelegate.self){TimerWrapper()}.scope(.application)
    
    // ViewModel
    Resolver.register(ContentViewModel.self){ContentViewModel()}.scope(.graph)
    
    // Usecase
    Resolver.register(MainTimerSettingDelegate.self){ TimerSettingService() }.scope(.graph)
    Resolver.register(RequestTimerDelegate.self){ LocalNotificationIntervalTimer() }.scope(.graph)
    Resolver.register(StateInitializerDelegate.self){StateInitializer()}.scope(.graph)
    
    // repository
    Resolver.register(UserSettingDBDelegate.self){ UserDefaultRepository() }.scope(.application)

    
    // entity
    Resolver.register(UserSettingStoreDelegate.self){UserSettingStore()}.scope(.application)
    Resolver.register(TimerStoreDelegate.self){TimerQueue()}.scope(.application)

}
