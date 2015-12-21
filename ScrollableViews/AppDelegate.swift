//
//  AppDelegate.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import Parse

private let STORYBOARD = "Users"
private let OTHER_STORYBOARD = "Main"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("AdcZBwd9CHJu1ED2pMlQeropO1Fl4DoMvvqxyEDW",
            clientKey: "312S6I5yd3UputqXKDQciNtJPz2twP0vM9Sxz136")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        checkForUserLogin()
        attemptPushNotifications(application, launchOptions: launchOptions)
        
        return true

    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Store the deviceToken in the current Installation and save it to Parse
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
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
    
    func checkForUserLogin() {
        if PFUser.currentUser() != nil {
            guard let currentUser = PFUser.currentUser() else { return }
            let initialVC = UIStoryboard(name: STORYBOARD, bundle: nil).instantiateInitialViewController()
            window?.rootViewController = initialVC
            
            let currentInstallation =  PFInstallation.currentInstallation()
            currentInstallation["installationUser"] = currentUser.objectId
            
            if currentInstallation.badge != 0 {
                currentInstallation.badge = 0
                currentInstallation.saveInBackgroundWithBlock({ (bool, error) -> Void in
                    if error != nil {
                        print("error \(error)")
                    } else {
                        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                        print("woohoo")
                        
                    }
                    
                })
                
            }
            
        } else {
            let initalVC = UIStoryboard(name: OTHER_STORYBOARD, bundle: nil).instantiateInitialViewController()
            window?.rootViewController = initalVC
        }
        
        window?.makeKeyAndVisible()
        
    }
    
    func attemptPushNotifications(application:UIApplication, launchOptions: [NSObject: AnyObject]?) {
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
                
            }
            
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
                
            }
            
        }
        
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
            
        } else {
            application.registerForRemoteNotificationTypes([.Alert, .Badge, .Sound])
            
        }
        
    }

}