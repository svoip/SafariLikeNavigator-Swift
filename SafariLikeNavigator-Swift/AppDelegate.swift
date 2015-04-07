//
//  AppDelegate.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/2/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//


// TODO: When scrolling the menu, the child views have to bend little bit (is it UIDynamics?)




import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   
   // typealias CompletionBlock = (completionName: NSString) -> Void
   
   
   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      func cvBlock(/*completionName: String*/) -> (){
         println("hello from App delegate")
      }
      
      
      var controllers = [MenuChildController]()
      var controller = MenuChildController()
      
      controller.viewWillAppearBlock = {
         println("VC 1 will appear")
      }
      controller.viewWillDisappearBlock = {
         println("VC 1 will disappear")
      }
      
      controller.view.backgroundColor = UIColor.lightGrayColor()
      controller.view.layer.borderColor = UIColor.blackColor().CGColor
      controller.view.layer.borderWidth = 1
      controller.view.alpha = 0.5
      controllers.append(controller)
      
      
      
      controller = MenuChildController()
      controller.view.backgroundColor = UIColor.orangeColor()
      controller.view.layer.borderColor = UIColor.blackColor().CGColor
      controller.view.layer.borderWidth = 1
      controller.view.alpha = 0.5
      controller.viewWillAppearBlock = {
         println("VC 2 will appear")
      }
      controller.viewWillDisappearBlock = {
         println("VC 2 will disappear")
      }
      controllers.append(controller)
      
      controller = MenuChildController()
      controller.view.backgroundColor = UIColor.greenColor()
      controller.view.layer.borderColor = UIColor.blackColor().CGColor
      controller.view.layer.borderWidth = 1
      controller.view.alpha = 0.5
  
      controller.viewWillAppearBlock = {
         println("VC 3 will appear")
      }
      controller.viewWillDisappearBlock = {
         println("VC 3 will disappear")
      }
      controllers.append(controller)
   
     //
      controller = MenuChildController()
      controller.view.backgroundColor = UIColor.blueColor()
      controller.view.layer.borderColor = UIColor.blackColor().CGColor
      controller.view.layer.borderWidth = 1
      controller.view.alpha = 0.5
      
      controller.viewWillAppearBlock = {
         println("VC 4 will appear")
      }
      controller.viewWillDisappearBlock = {
         println("VC 4 will disappear")
      }
      controllers.append(controller)
      
      //
      controller = MenuChildController()
      controller.view.backgroundColor = UIColor.purpleColor()
      controller.view.layer.borderColor = UIColor.blackColor().CGColor
      controller.view.layer.borderWidth = 1
      controller.view.alpha = 0.5
      
      controller.viewWillAppearBlock = {
         println("VC 5 will appear")
      }
      controller.viewWillDisappearBlock = {
         println("VC 5 will disappear")
      }
      //controllers.append(controller)
      
      
      
      var menu = MenuController(nibName: nil, bundle: nil, childControllers: controllers)
      
      self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
      self.window?.rootViewController = menu
      self.window?.makeKeyAndVisible()
      
      return true
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

