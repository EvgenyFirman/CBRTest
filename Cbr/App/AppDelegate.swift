//
//  AppDelegate.swift
//  Cbr
//  Created by Евгений Фирман on 24.06.2021.

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var currency: [Currency] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        notificationCenter.getNotificationSettings { (settings) in
          if settings.authorizationStatus != .authorized {
            // Notifications not allowed
          }
        }
        
        XMLParserClass().URLSetter()
        
        let data = XMLParserClass().currency
        
        if Float(data.last!.value)! > ViewController().defaults.float(forKey: "price") {
            
            self.scheduleNotification()
            
        } else {
            
        }

        return true
        
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Уведомление!!"
        content.body = "Курс доллара больше установленного в приложении"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let date = Date(timeIntervalSinceNow: 3600)
        let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute, .second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
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
    
    
    
  
    
  
}



