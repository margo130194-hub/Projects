//
//  AppDelegate.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        requestPermission()
        NotificationService.shared.resetBadge()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    //MARK: Actions
    
    func requestPermission(){
        UNUserNotificationCenter.current()
            .getNotificationSettings{ settings in
                if settings.authorizationStatus == .notDetermined{
                    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert])
                    { granted, error in
                        if let error = error{
                            print("\(error.localizedDescription)")
                            return
                        }
                        if granted {
                            do {
                                try NotificationService.shared.scheduleAdvices()
                            } catch {
                                print("error \(error.localizedDescription)")
                            }
                            DispatchQueue.main.async{
                                UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
                            }
                        } else {
                            DispatchQueue.main.async{
                                UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
                            }
                        }
                    }
                } else if settings.authorizationStatus == .authorized{
                        DispatchQueue.main.async{
                            UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
                        }
                    }
                }
            }
    }
    

extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}
