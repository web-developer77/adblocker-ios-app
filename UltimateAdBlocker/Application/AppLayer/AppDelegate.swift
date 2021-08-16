//
//  AppDelegate.swift
//  UltimateAdBlocker

import UIKit
import ApphudSDK
import SnapKit
import iAd
import UserNotifications

let sharedUserDeafults = UserDefaults(suiteName: SharedUserDeafults.suiteName)

var hasActiveSubscription: Bool {
    return Apphud.hasActiveSubscription()
    
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_BmMnpVp8QdFLBm1ega4yjsmAt24kbx")
        
        
        registerForNotifications()
        
        ADClient.shared().requestAttributionDetails { (data, error) in
                if let data = data {
                    Apphud.addAttribution(data: data, from: .appleSearchAds, callback: nil)
                }
            }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = LoadingViewController.instantiate(from: .loading)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func registerForNotifications(){
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])    { (granted, error) in
           
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Apphud.submitPushNotificationsToken(token: deviceToken, callback: nil)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
   
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Apphud.handlePushNotification(apsInfo: response.notification.request.content.userInfo)
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Apphud.handlePushNotification(apsInfo: notification.request.content.userInfo)
        completionHandler([])
    }

}

