//
//  AppDelegate.swift
//  pocSlideMenu
//
//  Created by Vanoshan  Ramdhani on 2020/03/14.
//  Copyright © 2020 Vanoshan  Ramdhani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
    
        window!.makeKeyAndVisible()
        window?.rootViewController =  ContainerViewController()
        return true
    }

}

