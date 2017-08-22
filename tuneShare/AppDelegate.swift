//
//  AppDelegate.swift
//  tuneShare
//
//  Created by Raj Patel on 6/29/17.
//  Copyright © 2017 vrknights. All rights reserved.
//

import UIKit
import CoreData
import TwitterKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Fabric.with([Twitter.self])
        
        
        let filePath = Bundle.main.path(forResource: "GoogleService-Info(1)", ofType: "plist")
        guard let fileopts = FIROptions.init(contentsOfFile: filePath!)
            else { assert(false, "Couldn't load config file")}
        FIRApp.configure(with: fileopts)
        
        
        
//        googleAppID: "1:297674645078:ios:5cb5b4a68d7e89e2", bundleID: "RajPatel.tuneShare", gcmSenderID: "297674645078", apiKey: "AIzaSyBUIXvNtsUT4gsoXL7HeobQi5DCqKNBxMk", clientID: "297674645078-qthhugkvk5muhtetcg7mauheq99mujto.apps.googleusercontent.com", trackingID: <#T##String!#>, androidClientID: <#T##String!#>, databaseURL: "https://tuneshare-39fcf.firebaseio.com", storageBucket: "tuneshare-39fcf.appspot.com", deepLinkURLScheme: <#T##String!#>)
        
        
        
//        FIRApp.configure(with: secondaryOptions!)
        IQKeyboardManager.sharedManager().enable = true
        Twitter.sharedInstance().start(withConsumerKey: "i3kaoCJhUkTU2VFKy1Rmiuhw1", consumerSecret: "NJADMniNk8XiHenJje7iB0OMGCji3SeZAcVw5ou9cQGBCmfCCP")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "tuneShare")
        container.loadPersistentStores(completionHandler: { (storeDescription,
            error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately. // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or
                 disallows writing.
                 * The persistent store is not accessible, due to permissions or
                 data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

