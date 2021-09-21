//
//  Model.swift
//  Model
//
//  Created by Anfernee Viduya on 9/16/21.
//

import Foundation
import UIKit
import UserNotifications

class Model : ObservableObject {
    @Published var level = UIDevice.current.batteryLevel
    @Published var brightness = UIScreen.main.brightness
    
    
    @Published var thresholds: Float {
        didSet {
            UserDefaults.standard.set(thresholds, forKey: "Thresholds")
        }
    }
    
    @Published var notifAmount: Int {
        didSet {
            UserDefaults.standard.set(notifAmount, forKey: "Notif")
        }
    }

    var timer = Timer()
    var notifTimer = Timer()
    
    init () {
        self.thresholds = UserDefaults.standard.float(forKey: "Thresholds")
        self.notifAmount = UserDefaults.standard.integer(forKey: "Notif")
        UIDevice.current.isBatteryMonitoringEnabled = true
        assignLevelPublisher()
    }
    
    func startLiveUpdates() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(_) in self.reloadData()})
        notifTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(_) in self.thresholdTriggerNotif()})
    }
    
    func notifAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Charge Yo Phone!"
        content.subtitle = "Bro you just reached \(thresholds)% you told me to remind you about"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (5), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func thresholdTriggerNotif(){
        let threshold = thresholds
        let lvl = level
        
        if lvl <= threshold {
            setNotification()
        }
    }
    
    private func reloadData() {
        let newBrightness = UIScreen.main.brightness
        brightness = newBrightness
        let newLevel = UIDevice.current.batteryLevel
        level = newLevel
    }

    private func assignLevelPublisher() {
        _ = UIDevice.current
            .publisher(for: \.batteryLevel)
            .assign(to: \.level, on: self)
    }
}

