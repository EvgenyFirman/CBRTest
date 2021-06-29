//
//  AppDelegate.swift
//  Cbr
//  Created by Евгений Фирман on 24.06.2021.
//

import UIKit
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initializing request for notifications
        notificationCenter.requestAuthorization(options: [.alert,.sound, .alert]) { (granted, erro) in
            
            guard granted else {
                return
            }
            self.notificationCenter.getNotificationSettings { settings in
    
                guard settings.authorizationStatus == .authorized else {return}
            }
        }
        
        XMLParserClass().URLSetter()
        
        let data = XMLParserClass().currency
        
        let value = data.last?.value
        
        if let safeValue = value {
            
            
            
            let userSetPrice = ViewController().defaults.float(forKey: "price")
            
            if Float(safeValue)! > userSetPrice {
                
                sendNotifications()
                
            } else {
                
            }
            
        }
        
        return true

    }
    
    func sendNotifications(){
        
        let content = UNMutableNotificationContent()
        content.title = "Привет!"
        content.body = "Курс доллара больше установленного в приложении"
        content.sound = UNNotificationSound.default
        
        let trigger  =  UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            
            print(error?.localizedDescription)
        }
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
    }
}


