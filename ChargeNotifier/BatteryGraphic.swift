//
//  BatteryGraphic.swift
//  BatteryGraphic
//
//  Created by Anfernee Viduya on 9/16/21.
//

import SwiftUI

struct BatteryGraphic: View {
    var color1 = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    var color2 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var width: CGFloat
    var height: CGFloat
    var percent: CGFloat
    var body: some View {
        let multiplier = width / 44
        let progress = 1.27 - (percent / 100)
        
        return ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            Circle()
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            Image(systemName: "bolt")
                .font(.system(size: 18 * multiplier))
            
        }
    }
}
