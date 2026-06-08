//
//  NotificationService.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 03/06/2026.
//

import Foundation
import UserNotifications

enum PlistError: LocalizedError{
    case fileNotFound
    case dataCorrupted
    
    var errorDescription: String?{
        switch self {
        case .fileNotFound:
            return "файл не найден"
        case .dataCorrupted:
            return "файл поврежден"
        }
    }
    
}
final class NotificationService {
    static let shared = NotificationService()
    private init(){}
    
    private func getAdvice() throws -> [String]{
        guard let url = Bundle.main.url(forResource: "BankAdvices", withExtension: "plist") else {
            throw PlistError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let advices = try decoder.decode([String].self, from: data)
            guard !advices.isEmpty else {throw PlistError.dataCorrupted }
            return advices
        }
        catch{
            throw PlistError.dataCorrupted
        }
        
    }
    
    func scheduleAdvices() throws{
        let advices = try getAdvice()
        for day in 1...7{
            let content = UNMutableNotificationContent()
            content.title = "Gravity Bank"
            
            let advice = advices.randomElement()
            content.body = advice ?? "Хорошего дня!"
            content.sound = .default
            
            var date = DateComponents()
            date.weekday = day
            date.hour = 11
            date.minute = 00
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let identifier = "dailyAdvice\(day)"
            let request = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: trigger)
            UNUserNotificationCenter.current().add(request){error in
                if let error = error {
                    print("Ошибка \(identifier): \(error.localizedDescription)")
                }
            }
        }
    }
    
    func removeAllNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func resetBadge(){
        UNUserNotificationCenter.current().setBadgeCount(0){error in
            if let error = error{
                print("\(error.localizedDescription)")
            }
        }
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
