//
//  ContentView.swift
//  ChargeNotifier
//
//  Created by Anfernee Viduya on 9/16/21.
//

import SwiftUI
import UserNotifications


struct ContentView: View {
    @State var isShowingSettings = false
    
    @StateObject var model: Model
    
    var batteryPercentage: Float {
        let batterylvl = model.level
        return batterylvl * 100
    }
    
    var brightnessPercentage: CGFloat {
        let brtLvl = model.brightness
        return brtLvl * 100
    }
    
    var computedGreeting: String {
        switch batteryPercentage {
        case let lvl where lvl < 20:
            return "Silly goofy mood?🤪"
        case let lvl where lvl <= 30:
            return "Pat, charge your phone😤"
        case let lvl where lvl == 50:
            return "We're at 50 now🙄"
        case let lvl where lvl > 75:
            return "We're still good captain!😛"
        case let lvl where lvl >= 90:
            return "Wow this is alot!"
        default:
            return "I dont know what im doing"
        }
    }
    
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                BatteryGraphic(width: 200, height: 200, percent: brightnessPercentage)
                    .padding(.vertical)
                Text("Estimated Energy Usage")
                    .font(.caption)
                    .foregroundColor(.gray)
                Form {
                    Section(header: Text("Main Info")) {
                        HStack {
                            Text("Battery Percentage")
                            Spacer()
                            Text("\(batteryPercentage ,specifier: "%2.f")%")
                        }
                        HStack {
                            Text("Screen Brightness")
                            Spacer()
                            Text("\(brightnessPercentage ,specifier: "%2.f")%")
                        }
                    }
                    
                }
                
            }
            .navigationTitle(Text(computedGreeting))
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings.toggle()
            }, label: {
                Image(systemName: "pencil.circle")
            }))
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(model: model)
        }
        .onAppear {
            model.startLiveUpdates()
            model.notifAccess()
            print(model.startLiveUpdates())
        }
    }
}
