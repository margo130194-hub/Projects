//
//  NotificationPresenter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 31/05/2026.
//

import Foundation
import UserNotifications
import UIKit


final class NotificationPresenter: NotificationPresenterProtocol{
    
    weak var view : NotificationViewProtocol?
    var router: NotificationRouterProtocol?
    
    func notificationSwitch(isOn: Bool) {
        if isOn {
            UNUserNotificationCenter.current().getNotificationSettings{[weak self] settings in
                DispatchQueue.main.async {
                    if settings.authorizationStatus == .denied{
                        self?.view?.setupSwitch(isOn: false)
                        UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
                        if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                           UIApplication.shared.canOpenURL(settingsUrl){
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                    else {
                        UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
                        try? NotificationService.shared.scheduleAdvices()
                        self?.view?.setupSwitch(isOn: true)
                    }
                }
            }
        }
        else {
            UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
            NotificationService.shared.removeAllNotifications()
        }
    }
    
    func viewDidLoad() {
        let savedValue = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
        self.view?.setupSwitch(isOn: savedValue)
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .denied && savedValue == true {
                    UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
                    self?.view?.setupSwitch(isOn: false)
                }
                
            }
            
        }
    }
}
