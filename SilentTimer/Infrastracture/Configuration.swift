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
    // entity
    Resolver.register(UserSettingStoreDelegate.self){UserSettingStore()}.scope(.application)
    Resolver.register(TimerStoreDelegate.self){TimerQueue()}.scope(.application)

}
