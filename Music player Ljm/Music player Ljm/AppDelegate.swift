//
//  AppDelegate.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/26.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0 , *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    /*
     *
     *   后台任务
     *
     */
//    var backGroundTask:UIBackgroundTaskIdentifier! = nil
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        window = UIWindow(frame: screenBounds)
        /* 设置背景图片 */
        let bgImage = UIImageView()
        bgImage.frame = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64 - UIApplication.shared.statusBarFrame.height)
        bgImage.image = UIImage(named: "bg")
//        bgImage.alpha = 0.6
//        view.addSubview(bgImage)
//        window?.addSubview(bgImage)
        
        /*
         *
         *  设置图片背景的模糊效果
         *
         */
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0,
                                y: 0,
                                width: screenWidth,
                                height: screenMaxY - 64 - UIApplication.shared.statusBarFrame.height)
        bgImage.addSubview(blurView)
        window?.addSubview(bgImage)

        
        
//        let favorites = musicListTableviewcontroller(style: UITableViewStyle.plain)
        let favorites = musicListTableviewcontroller()
        
        
//        favorites.title = "music";
        
//        let down = downloadMusicTableViewController(style: UITableViewStyle.plain)
        let down = downloadMusicTableViewController()
        
        down.title = "下载列表";
        
        let favoritesNav = navigationcontroller(rootViewController: favorites)
        favoritesNav.tabBarItem.image = UIImage(named: "music")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        favoritesNav.tabBarItem.selectedImage = UIImage(named: "musics")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let downNav = navigationcontroller(rootViewController: down)
        downNav.tabBarItem.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal)
        downNav.tabBarItem.selectedImage = UIImage(named: "downs")?.withRenderingMode(.alwaysOriginal)
        
        
        let tab = tabbarcontroller()
        tab.addChildViewController(favoritesNav)
        tab.addChildViewController(downNav)
        
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    
    
    
    //MARK: - 程序进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        let controller = self.window?.rootViewController as! ViewController
        
         //MARK:- 如果后台存在任务，先将后台任务完成
//        if self.backGroundTask != nil {
//            application.endBackgroundTask(self.backGroundTask)
//            self.backGroundTask = UIBackgroundTaskInvalid
//        }else
//        {
//            
//            self.backGroundTask = application.beginBackgroundTask(expirationHandler: {
//                
//                application.endBackgroundTask(self.backGroundTask)
//                self.backGroundTask = UIBackgroundTaskInvalid
//            })
//        }
        
        
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

    
    
    
    //MARK: -   core data stack
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Music")
        container.loadPersistentStores(completionHandler: { (storeDescription , error) in
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error) , \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    //MARK: -   coar data saving

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror) , \(nserror.userInfo)")
            }
        }
        
    }
    
}

