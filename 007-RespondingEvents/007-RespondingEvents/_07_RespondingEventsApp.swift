//
//  _07_RespondingEventsApp.swift
//  007-RespondingEvents
//
//  Created by 舒毅文 on 2024/2/26.
//

import SwiftUI

//@main
//struct _07_RespondingEventsApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

//要做到这一点，首先创建一个自定义类，继承自NSObject并遵守UIApplicationDelegate协议。
class Appdelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("applicationDidFinishLaunching")
        return true
    }
}

@main
struct _07_RespondingEventsApp: App {
    //使用UIApplicationDelegateAdaptor属性包装器来告诉SwiftUI它应该使用你的AppDelegate类作为delegate
    @UIApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
