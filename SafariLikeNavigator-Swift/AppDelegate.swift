//
//  AppDelegate.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/2/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   
   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      let count = 8
      var controllers = [MenuController]()
      for var i=1; i<=count; i++
      {
         let vc = MenuController()
         vc.index = i
         vc.view.backgroundColor = getRandomColor()
         vc.viewWillAppearBlock = {
            p in
            println("VC__ \(p) will appear")
         }
         vc.viewWillDisappearBlock = {
            p in
            println("VC__ \(p) will disappear")
         }
         controllers.append(vc)
      }

      var menu = MenuContainer(nibName: nil, bundle: nil, childControllers: controllers)
      self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
      self.window?.rootViewController = menu
      self.window?.makeKeyAndVisible()
      return true
   }
   
   func getRandomColor() -> UIColor {
      let r = CGFloat(drand48())
      let g = CGFloat(drand48())
      let b = CGFloat(drand48())
      let color = UIColor(red: r, green: g, blue: b, alpha: 1)
      return color
   }

   func applicationWillResignActive(application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   }
   
   func applicationDidEnterBackground(application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }
   
   func applicationWillEnterForeground(application: UIApplication) {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   }
   
   func applicationDidBecomeActive(application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }
   
   func applicationWillTerminate(application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }
   
   
}

