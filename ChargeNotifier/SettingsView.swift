//
//  SettingsView.swift
//  SettingsView
//
//  Created by Anfernee Viduya on 9/16/21.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @ObservedObject var model: Model

    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Threshold for Notification")) {
                        HStack {
                            Text("\(model.thresholds, specifier: "%2.f")")
                            Slider(value: $model.thresholds,
                                   in: 0...100,
                                   step: 1,
                                   minimumValueLabel: Image(systemName: "battery.0"),
                                   maximumValueLabel: Image(systemName: "battery.100"),
                                   label: {
                                Text("Threshold")
                            }
                            )
                        }
                        
                        
                    }
                    Section(header: Text("Notification Amount")) {
                        Stepper(
                            "\(model.notifAmount)",
                            value: $model.notifAmount,
                            in: 1...10
                        )
                    }
                    
                }
            }
            .navigationTitle(Text("Adjust it or whateves🙄"))
        }
        
    }
}
